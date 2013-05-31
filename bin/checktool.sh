#!/bin/sh -u
#
# usage:
#	tools/checktool.sh  [sub-command(help|check|pack|recreate|install|rollback|remote):-help]
#
ADIR=$( cd $(dirname $0) && pwd )
BDIR=${ADIR%%/tools}     # ./ , ./tools�ǂ���ł��N����,�ʏ��tools�ȉ�

cd $BDIR
if [ ! -e $ADIR/_filter.pl ];then
	cat > $ADIR/_filter.pl <<-'_EOF_'
		#!/usr/bin/perl -nl
		use strict;
		use warnings;

		# �t�@�C���p�[�~�b�V�����Ɋւ���萔���C���|�[�g
		use Fcntl ':mode';

		s/#.+$//;        # �R�����g���폜
		s/\s+$//;        # ���̃X�y�[�X�����폜
		s/^.+\s+//;      # �Ō�̃X�y�[�X�ȍ~���t�@�C�����Ƃ��Ďc��
		s/\*$//;         # �Ō��'*'������

		next if /^\s*$/;        # �X�y�[�X�A��s���X�L�b�v
		next if /^_recycle$/;   # �g�b�v��_recycle���X�L�b�v
		next if /^_recycle\//;  # �g�b�v��_recycle�����X�L�b�v
		next if /\/_recycle$/;  # _recycle���X�L�b�v
		next if /\/_recycle\//; # _recycle�����X�L�b�v
		

		# stat�֐��̖߂�l��3�ڂ̗v�f���t�@�C��
		# �p�[�~�b�V�����̏��
		my @sts = stat;

		# ���L�҃��[�UID(���l)���烆�[�U�����擾����
		my $uname = getpwuid $sts[4];

		# ���L�O���[�vID(���l)����O���[�v�����擾����
		my $gname = getgrgid $sts[5];


		# Size���擾����
		my $siz = $sts[7];


		# cksum
		my $chk = '';

		if ( S_ISREG($sts[2]) ) {
		  #localtime�Ō��n���Ԃɕϊ�
		  my($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime($sts[9]);

		  $chk = `cksum $_` ;
		  chomp $chk;
		  $chk =~ s/ .+$//;
		  
		  my $flp = $_;
		  $flp =~ s{^[^/ ]+/}{./};

		  # �p�[�~�b�V������S_IMODE�֐��Ő��l�ɕϊ�
		  printf "%-50s\t#\t%03o \t%-8s\t%-8s\t%04d/%02d/%02d %02d:%02d:%02d \t%8d\t%s\n"
		    , $flp, S_IMODE($sts[2]), $uname, $gname, $year+1900, $mon+1, $mday, $hour, $min, $sec, $siz, $chk;
#		    , $_, S_IMODE($sts[2]), $uname, $gname, $year+1900, $mon+1, $mday, $hour, $min, $sec, $siz, $chk;
		} else {
		  $_ = "$_/" unless /\/$/;
		  
		  # �g�b�v�t�H���_�i��Fscripts�j�͉ςȂ̂Œu��
		  my $flp = $_;
		  $flp =~ s{^[^/ ]+/}{./};

		  # �p�[�~�b�V������S_IMODE�֐��Ő��l�ɕϊ�
		  printf "%-50s\t#\t%03o \t%-8s\t%s\n"
		    , $flp, S_IMODE($sts[2]), $uname, $gname;
#		    , $_, S_IMODE($sts[2]), $uname, $gname;
		};
	_EOF_
	chmod 755 $ADIR/_filter.pl
fi

if [ ! -e $ADIR/_diff.pl ];then
	cat > $ADIR/_diff.pl <<-'_EOF_'
		#!/usr/bin/perl
		use strict;
		use warnings;

		my ( $src,$upd ) = @ARGV;

		open SRC,"<",$src or die "not found '$src'";
		open UPD,"<",$upd or die "not found '$upd'";

		my %h;
		my ( $oldver,$updver ) = ( 'n/a','n/a' );
		while(<SRC>){
		  chomp;
		  next if /^\s*$/;
		  
		  s/^# Version : /Version # /;
		  s/\s+/ /g;
		  my ( $key,$val ) = split / # /;
		  if ( $key eq 'Version' ){
		    $oldver = $val;
		  } else {
		    # key�̐擪�t�H���_��'.'�ȉ��͖�������
		    # $key =~ s{^([^/.\s]+)\.[^/\s]+}{$1};
		    
		    $h{$key} = $val;
		  }
		}
		close SRC;

		while(<UPD>){
		  chomp;
		  next if /^\s*$/;

		  s/^# Version : /Version # /;
		  s/\s+/ /g;
		  my ( $key,$val ) = split / # /;
		  if ( $key eq 'Version' ){
		    $updver = $val;
		  } else {
		    # key�̐擪�t�H���_��'.'�ȉ��͖�������
		    # $key =~ s{^([^/.\s]+)\.[^/\s]+}{$1};
		    
		    if ( exists $h{$key} ) {
		      if ( $h{$key} eq $val ){
		        delete $h{$key};
		      } else {
		        my @ele1 = split /\s+/ ,$h{$key};
		        my @ele2 = split /\s+/ ,$val;
		        my $eln = $#ele1;
		        if ( $eln < 6 ) {
		            # permition ���قȂ�
		            $h{$key} = "chg perm";
		        } else {
		          if ( $ele1[6] ne $ele2[6] ) {
		            # cksum ���قȂ�
		            if ( "$ele1[0] $ele1[1] $ele1[2]" ne "$ele2[0] $ele2[1] $ele2[2]" ){
		              # �����permission ���قȂ�
		              $h{$key} = "mod+perm";
		            } else {
		              $h{$key} = "modified";
		            }
		          } else {
		            if ( "$ele1[0] $ele1[1] $ele1[2]" ne "$ele2[0] $ele2[1] $ele2[2]" ){
		              # permission ���قȂ�
		              $h{$key} = "chg perm";
		            } else {
		              $h{$key} = "chg date";
		            }
		          }
		        }
		      }
		    } else {
		      $h{$key} = "new file";
		    }
		  }
		}
		close UPD;
		#
		# Results
		#
		my $dcnt;
		if ( $oldver eq $updver ){
		  $dcnt = 0;
		  print "\n";
		  print "    Version      $updver\n\n";
		} else {
		  $dcnt = 1;
		  print "\n";
		  print "    Version      $oldver  ->  $updver\n\n";
		}
		for my $key ( sort keys %h){
		  $dcnt++;
		  my $val = $h{$key};
		  $h{$key} = "deleted " if $val !~ /new file|modified|mod\+perm|chg perm|chg date/;
		  
		  printf "    %s:    %s\n",$h{$key},$key;
		}

		if ( $dcnt == 0 ){
		  print "\n";
		  print "    identified\n";
		  exit
		} else {
		  print "\n";
		  print "    different\n";
		  exit 1
		} 
	_EOF_
	chmod 755 $ADIR/_diff.pl
fi

if [ ! -e $ADIR/_CRchk.sh ];then
	cat > $ADIR/_CRchk.sh <<-'_EOF_'
		#!/bin/sh -u
		(( $# > 0 )) || { echo "script requires 1 argument"; exit 1 ; }
		chk="$( cat $1 | perl -nle 'print "$.:$_" if /\r/' )"
		if [[ "$chk" = '' ]];then
		  echo "ok  $1"
		else
		  echo "NG  $1"
		  echo "$chk"  |head -5 >&2
		  echo 
		  echo "$1 ��CR�����݂��܂�"
		  exit 1
		fi
	_EOF_
	chmod 755 $ADIR/_CRchk.sh
fi

if [ ! -e $ADIR/_target.hosts ];then
	cat > $ADIR/_target.hosts <<-'_EOF_'
		mecerpa0111
		mecerpd0111
		mecerp2a0111
		mecerp2d0111
		mecerp3a0111
		mecerp3x0111
	_EOF_
fi

###
### Common Function
###
c_ver () {
  local _TARGET=${1:-scripts}
  local _DEFVER=${2:-unknow}
  if [ -e $_TARGET/.checklist ];then
    grep "# Version : " $_TARGET/.checklist | perl -ple 's/^.+ : //'
  else
    echo $_DEFVER
  fi
}

c_rev () {
  if [[ "${1:-}" = '-' ]];then
    _VER=${2:-unknown}
    echo  "# Version : $_VER"
  else
    local _TARGET=${1:-scripts}
    _TARGET=${_TARGET#@}
    
    if [ -d ${_TARGET} ];then
      if [ -e $_TARGET/.checklist ];then
        head -1 $_TARGET/.checklist
      else
        echo  "# Version : unknown"
      fi
    elif [ -r ${_TARGET} ];then
      head -1 ${_TARGET}
    else
      echo  "# Version : unknown"
    fi
  fi
}

c_ls () {
	if [[ "${1:-}" = '-s' ]];then
		_silent=on
		shift
	fi
	local _TARGET=${1:-scripts}
	local _DEFVER=${2:-unknow}
	#
	if [ -d "$_TARGET" ];then
		#
		# c_ls �t�H���_��
		#
		[[ "${_silent:-on}" = 'off' ]] && echo "Directory" >&2
		find "$_TARGET" ! -name .checklist | perl -nl $ADIR/_filter.pl
	elif  [[ "$_TARGET" = '@'*  && -d  ${_TARGET#@} ]];then
		#
		# c_ls @�t�H���_��
		#
		[[ "${_silent:-off}" = 'off' ]] && echo "Since the last release" >&2
		_TARGET=${_TARGET#@}
		if [ -e $_TARGET/.checklist ];then
			( cd  $_TARGET; cat .checklist  | perl -nl $ADIR/_filter.pl )
		fi
	elif [ -f "$_TARGET" ];then
		#
		# c_ls �`�F�b�N���X�g��
		#
		if [[ "$_TARGET" = *'.checklist'* ]];then
			[[ "${_silent:-off}" = 'off' ]] && echo "Check List" >&2
			egrep -v "^# Version : "  $_TARGET
		else
			echo "Unknown file" >&2
			return 1
		fi
	else
		echo "Unknown type" >&2
		return 1
	fi
}

c_sum () {
	if [[ "${1:-}" = '-s' ]];then
		_silent=on
		shift
	fi
	#
	local   _TARGET=${1:-scripts}
	integer _cnt=${2:-2}
	# Bash
	# ary=(    $( c_ls -s $_TARGET |cksum ) )
	set -A ary $( c_ls -s $_TARGET |cksum )
	if (( ${ary[1]} <= 1 ));then
		echo "invalid"
	else
		echo ${ary[0]}
	fi
	[[ "${_silent:-off}" = 'off' ]] && echo ${ary[1]} >&2
}

c_cmp () {
	local _SRC=$1
	typeset -i _src=$( c_sum -s $_SRC )

	local _UPD=$2
	typeset -i _upd=$( c_sum -s $_UPD )
	if (( _src == _upd ));then
		return 0
	else
		return 1
	fi
}

c_dif () {
	local _SRC=$1
	c_rev   $_SRC >  ./.checklist.src
	c_ls -s $_SRC >> ./.checklist.src
	local _UPD=$2
	c_rev   $_UPD >  ./.checklist.upd
	c_ls -s $_UPD >> ./.checklist.upd

	$ADIR/_diff.pl  ./.checklist.src  ./.checklist.upd
}
c_status () {
  local _TARGET=${1:-scripts}
  local _detail=${2:-}
  #
  _host=$(uname -n)
  _loca=$PWD/$_TARGET
  if (( ${#_loca} > 30 ));then
    _loca=${_loca##*/}
  fi
  _cver=$( c_ver $_TARGET )
  _csum=0
  _chgs='?'
  _ireg='?'
  _stat='not yet'
  #
  if [ -e $_TARGET/.checklist ];then
    _csum=$( c_sum -s $_TARGET/.checklist )
    if   c_cmp $_TARGET/.checklist  $_TARGET ;then
      _chgs='no'
      _ireg='no'
      _stat='identify'
    elif c_cmp $_TARGET/.checklist @$_TARGET ;then
      _chgs='no'
      _ireg='exists'
      _stat='no change'
    else
      _chgs='exists'
      _ireg='-'
      _stat='different'
    fi
  else
    _csum=$( c_sum -s $_TARGET )
  fi
  c_fmt="%-14s  %-30s  %-22s  %-6s  %-6s  %-9s\n"
  printf "$c_fmt" "�z�X�g"         "�t�H���_"                       "�o�[�W����(cksum)"     "�ύX"   "�s��"   "���"      >&2
  printf "$c_fmt" "--------------" "------------------------------" "---------------------" "------" "------" "---------" >&2
  sleep 1
  printf "$c_fmt" "$_host"         "$_loca"                         "$_cver ($_csum)"       "$_chgs" "$_ireg" "$_stat"

  if [ -e scripts/.checklist ];then
    if [[ $_detail = 'detail' ]];then
      if [[ $_stat != 'identify' ]];then
        echo
        echo "## �ύX�_"
        if [[ $_stat = 'different' ]];then
          c_dif $_TARGET/.checklist @$_TARGE
        else 
          c_dif $_TARGET/.checklist $_TARGET
        fi
      fi
    fi
  fi
}

###
### �����[�g�@�\
###
d_output (){
	c_rev    scripts
	c_ls -s  scripts
}
d_status (){
	c_status scripts
}

###
### ����@�\
###
f_recreate (){
  _FOLDER=${1:-$(  sel_folder )}
  _VERSION=${2:-$( inp_version $_FOLDER )}
  #
  [ -e $_FOLDER/.checklist ] && rm $_FOLDER/.checklist
  c_rev - "$_VERSION" >  $_FOLDER/.checklist
  c_ls -s "$_FOLDER"  >> $_FOLDER/.checklist
  chmod 400 $_FOLDER/.checklist
  echo
  echo "## �����`�F�b�N���X�g'$_FOLDER/.checklist'���č\�����܂���"
}

f_install (){
  _PACKAGE=${1:-$( sel_package )}
  #
  if [ ! -d scripts.$(date '+%Y%m%d') ];then
    cp -pr scripts scripts.$(date '+%Y%m%d')
    echo
    echo "## ���[���o�b�N�|�C���g'scripts.$(date '+%Y%m%d')'���쐬���܂���"
  fi
  tar -xvf ${_PACKAGE}
  echo
  echo "## �p�b�P�[�W'${_PACKAGE}'���C���X�g�[�����܂���"
}

f_package (){
  _VERSION=${1:-$( inp_version )}
  #
  [ -e scripts/.checklist ] && rm scripts/.checklist
  if [ -e ./scripts.exclude ];then
    echo ""
    echo "## './scripts.exclude'�t�@�C���̋L�q�p�^�[�������O���܂�"
    tar -cvf scripts_${_VERSION}.tar -X ./scripts.exclude scripts
  else
    tar -cvf scripts_${_VERSION}.tar scripts
  fi

  c_rev - "${_VERSION}" >  scripts/.checklist
  tar  -tvf scripts_${_VERSION}.tar | perl -nl $ADIR/_filter.pl >> scripts/.checklist
  tar  -rvf scripts_${_VERSION}.tar scripts/.checklist
  echo
  echo "## �p�b�P�[�W'scripts_${_VERSION}.tar'���쐬����܂���"
}

f_rollback (){
  _RBP=${1:-$( sel_rbp )}
  #
  if [ -d scripts ];then
    echo
    echo "!!ERROR"
    echo "!"
    echo "! 'scripts' �t�H���_�����݂��܂�"
    echo "! �蓮�� 'scripts' �t�H���_�����l�[�����邩�A�폜���Ă�������"
    echo "! rm -r scripts"
    echo "!"
    echo "!!ERROR"
    echo
    exit 1
  fi
  mv $_RBP scripts
}
f_deploy (){
  typeset -u _HOST=${1:-$( sel_host )}
  #
  echo  rdist -f tools/_distfile_each.txt "$_HOST"
  echo
  /usr/sbin/rdist -f tools/_distfile_each.txt "$_HOST"
  echo
  echo "## �t�@�C����z�z���܂���"
  echo
}

###
### �\���@�\
###
f_status (){
  echo "## �e�t�H���_�̏�ԋy�ѕύX�̗L����\�����܂�"
  echo
  
  c_status
  echo
  if [ -d scripts.* ];then
    for _RBP in $( find scripts.* -type d -prune );do
      c_status ${_RBP}  2>&-
    done
    echo
  fi
  #
  _FOLDER=${1:-$( sel_folder )}
  #
  if [ ! -e $_FOLDER/.checklist ];then
    echo
    echo "!!ERROR"
    echo "!"
    echo "! �����`�F�b�N���X�g'$_FOLDER/.checklist' ������܂���"
    echo "!"
    echo "! 'scripts/.checklist' �͖{���A�T�u�R�}���h'pack' �Ńp�b�P�[�W�쐬���ɍ쐬����܂�"
    echo "! ����ƌ��݂̃t�@�C�����`�F�b�N���邱�Ƃō쐬������t�@�C���̏�Ԃ��ύX����Ă��Ȃ�"
    echo "! ���Ƃ��m�F�ł��܂�"
    echo "!"
    echo "! ���݂̏�ԂŐ����`�F�b�N���X�g���쐬/�č쐬����ɂ́A�T�u�R�}���h'recreate'�ō쐬�ł��܂�"
    echo "!"
    echo "!!ERROR"
    echo
    exit 1
  fi
  
  _FIL='?'
  while  [[ "$_FIL" != ''  ]];do
    if   [[ "$_FIL" =  '?' ]];then
      echo "## �ύX�_"
      if c_cmp $_FOLDER/.checklist $_FOLDER;then
        echo
        echo "    �ύX�Ȃ�"
        break
      else
        c_rev   $_FOLDER >  ./.checklist.tmp
        c_ls -s $_FOLDER >> ./.checklist.tmp
        c_dif   $_FOLDER/.checklist ./.checklist.tmp
      fi
      echo
    else  
      echo
      echo  "$( uname -n ):/u00/unyo/$_FOLDER"
      echo
      fgrep "$_FIL " $_FOLDER/.checklist  | perl -ple 's/^.+#//;s/\s+/ /g'
      fgrep "$_FIL " ./.checklist.tmp     | perl -ple 's/^.+#//;s/\s+/ /g'
      echo " (��i�F�\��(�����[�X)�����̏�ԁ@�@���i�F���݂̏��)"
      if [[ "$_FOLDER" != 'scripts' ]];then
        echo
        echo "$( uname -n ):/u00/infra_release/scripts"
        echo
        fgrep "$_FIL " scripts/.checklist | perl -ple 's/^.+#//;s/\s+/ /g'
      fi
    fi
    #
    _FIL=$( inp_file )
  done
  echo
}

f_summary (){
  echo "## �e�T�[�o�̃C���X�g�[����ԋy�ѐ������`�F�b�N"
  echo
  
  c_status
  echo
  # local
  if [ -d scripts.* ];then
    for _RBP in $( find scripts.* -type d -prune );do
      c_status ${_RBP}  2>&-
    done
    echo
  fi
  # remote
  for _HOST in $( cat $ADIR/_target.hosts ) ;do
    rcp   $ADIR/checktool.sh root@${_HOST}:/u00/unyo
    if (( $? != 0 ));then
      echo "! ${_HOST} �ł̃`�F�b�N�����s���܂���"
    fi
    remsh ${_HOST} '/bin/sh /u00/unyo/checktool.sh d_status' 2>&-
    remsh ${_HOST} 'rm /u00/unyo/checktool.sh'
  done
  echo
}

f_detail (){
  _HOST=${1:-$( sel_host )}
  echo
  echo "## 'scripts'�t�H���_�̃C���X�g�[����ԋy�ѕύX�̗L����\�����܂�"
  echo
  rcp   $ADIR/checktool.sh root@${_HOST}:/u00/unyo
  if (( $? != 0 ));then
    echo "! ${_HOST} �ł̃`�F�b�N�����s���܂���"
  fi
  remsh ${_HOST} '/bin/sh /u00/unyo/checktool.sh d_status'
  rcp   root@${_HOST}:/u00/unyo/scripts/.checklist  ./.checklist.${_HOST}
  
  _FIL='?'
  while  [[ "$_FIL" != ''  ]];do
    if   [[ "$_FIL" =  '?' ]];then
      remsh ${_HOST} '/bin/sh /u00/unyo/checktool.sh d_output' > ./.checklist
      echo "## checklist�\��(�����[�X��)�ȍ~�̕ύX�_"
      if c_cmp ./.checklist.${_HOST} ./.checklist;then
        echo
        echo "    �ύX�Ȃ�"
        break
      else
        c_dif ./.checklist.${_HOST}  ./.checklist
      fi
    else  
      echo
      echo  "${_HOST}:/u00/unyo/scripts"
      echo
      fgrep "$_FIL " ./.checklist.${_HOST} | perl -ple 's/^.+#//;s/\s+/ /g'
      fgrep "$_FIL " ./.checklist          | perl -ple 's/^.+#//;s/\s+/ /g'
      echo " (��i�F�\��(�����[�X)�����̏�ԁ@�@���i�F���݂̏��)"
      echo
      echo "$( uname -n ):/u00/infra_release/scripts"
      echo
      fgrep "$_FIL " scripts/.checklist    | perl -ple 's/^.+#//;s/\s+/ /g'
    fi
    #
    _FIL=$( inp_file )
  done
  
  remsh ${_HOST} 'rm /u00/unyo/checktool.sh'
  echo
}

f_ldiff (){
  _RBP=${1:-$( sel_rbp )}
  #
   echo
   echo "## checklist�̕ύX�_���`�F�b�N���܂�"
   c_dif   @$_RBP  scripts
}

f_rdiff (){
  _host=${1:-$( sel_host )}
  typeset -u _HOST="$_host"
  #
  rcp   $ADIR/checktool.sh root@${_host}:/u00/unyo
  if (( $? != 0 ));then
    echo
    echo "!!ERROR"
    echo "!"
    echo "! ${_HOST} �ł̃`�F�b�N�����s���܂���"
    echo "!"
    echo "!!ERROR"
    echo
    exit 1
  fi
  remsh ${_host} '/bin/sh /u00/unyo/checktool.sh d_output' > .checklist
  remsh ${_host} 'rm /u00/unyo/checktool.sh'

  echo "## �t�@�C���̍���"
  c_dif .checklist  @scripts
  echo
  echo "## �z�z�\��( rdist -v -f tools/_distfile_each.txt $_HOST )"
  echo
  /usr/sbin/rdist -v -f tools/_distfile_each.txt "$_HOST"
  echo
  echo "## ���j���ۂɕύX���ꂽ�킯�ł͂���܂���"
  echo
}

###
### ���͕⏕
###
sel_folder () {
  local _TARGET
  {
    echo
    echo '#? �t�H���_�̔ԍ���I�����Ă�������'
    PS3='>> '
    select _TARGET in $( find scripts* -type d -prune );do
      echo
      break
    done
  } >&2
  echo $_TARGET
}
sel_rbp () {
  local _TARGET
  {
    echo
    echo '#? ���[���o�b�N�|�C���g�̔ԍ���I�����Ă�������'
    PS3='>> '
    select _TARGET in $( find scripts.* -type d -prune );do
      echo
      break
    done
  } >&2
  echo $_TARGET
}
sel_package () {
  local _TARGET
  {
    echo
    echo '#? �p�b�P�[�W�̔ԍ���I�����Ă�������'
    PS3='>> '
    select _TARGET in $( ls scripts_v*.tar );do
      echo
      break
    done
  } >&2
  echo $_TARGET
}
sel_host () {
  local _HOST
  {
    echo
    echo '#? �����[�g�z�X�g�̔ԍ���I�����Ă�������'
    PS3='>> '
    select _HOST in $( cat $ADIR/_target.hosts );do
      echo
      break
    done
  } >&2
  echo $_HOST
}

inp_version () {
  local _VERSION
  {
    echo
    echo "#? �o�[�W��������͂��Ă������� (���o�[�W����: $( c_ver ${1:-} ))" 
    read _VERSION?'>> '
  } >&2
  echo $_VERSION
}
inp_file  (){
  local _basedir=${1:-}
  #
  local _FILE=''
  {
    echo
    echo "#? �t�@�C��������͂��Ă�������(��s�ŏI��)" 
    while read _FILE?'>> ';do 
      [[ "$_FILE" = '?' ]]  && break
      [[ "$_FILE" = ''  ]]  && return 1
      #
      if [[ "$_basedir" != '' ]];then
        ( cd $_basedir ) || exit 1
        _FILE=$( cd $_basedir && cd $( dirname "$_FILE" ) && pwd )/$( basename "$_FILE" )
        if [ -e "$_FILE" ];then
          break
        else
          echo "not found $_FILE"
        fi
      else
        # no check
        break
      fi
    done
  } >&2
  echo $_FILE
}
inp_ok (){
  local -u _OK=''
  {
    echo
    echo "#? ��낵���ł����H(��s�FOK)" 
    read _OK?'>> '
    [[ $_OK = '' ]] && _OK='OK'
  } >&2
  echo $_OK
}

##
## For Debug
##
sel_func () {
  local _FUNC
  {
    echo
    echo '#? �t�@���N�V�����̔ԍ���I�����Ă�������'
    PS3='>> '
    select _FUNC in $( typeset -f |grep function |perl -ple 's/function //' ) ;do
      echo
      break
    done
  } >&2
  echo $_FUNC
}
f_trace () {
  local _FUNC=${1:-$( sel_func )}
  #
  #
  export PS4='        +$LINENO	'
  
  local tron=$( typeset -ft |grep "$_FUNC" )
  if [[ "$tron" = "" ]];then
    typeset -ft $_FUNC
  else
    typeset +ft $_FUNC
  fi
}
f_rcpcl () {
  _FLDR=${1:-$( sel_folder )}
  _HOST=${2:-$( sel_host   )}
  #
  echo rcp $_FLDR/.checklist root@${_HOST}:/u00/unyo/scripts/
  rcp      $_FLDR/.checklist root@${_HOST}:/u00/unyo/scripts/
  echo 
  echo "## ${_HOST}��$_FLDR/.checklist���R�s�[���܂���"
  echo
}

##
## tools
##
f_tools () {
  _HOST=${1:-$( sel_host )}
  rcp   $ADIR/checktool.sh root@${_HOST}:/u00/unyo
  echo "## ${_HOST}��/u00/unyo/checktool.sh ���R�s�[���܂���"
  echo
}
f_recycle (){
  if [ ! -e scripts/.checklist ];then
    echo
    echo "!!ERROR"
    echo "!"
    echo "! �����`�F�b�N���X�g'$_FOLDER/.checklist' ������܂���"
    echo "!"
    echo "! 'scripts/.checklist' �͖{���A�T�u�R�}���h'pack' �Ńp�b�P�[�W�쐬���ɍ쐬����܂�"
    echo "! ����ƌ��݂̃t�@�C�����`�F�b�N���邱�Ƃō쐬������t�@�C���̏�Ԃ��ύX����Ă��Ȃ�"
    echo "! ���Ƃ��m�F�ł��܂�"
    echo "!"
    echo "! ���݂̏�ԂŐ����`�F�b�N���X�g���쐬/�č쐬����ɂ́A�T�u�R�}���h'recreate'�ō쐬�ł��܂�"
    echo "!"
    echo "!!ERROR"
    echo
    exit 1
  fi
  c_status
  echo
  
  _FIL='?'
  while  [[ "$_FIL" != ''  ]];do
    if   [[ "$_FIL" =  '?' ]];then
      echo "## �s��v�f(new file)"
      if c_cmp scripts/.checklist scripts;then
        echo
        echo "    new file�Ȃ�"
      else
        c_dif  scripts/.checklist scripts
      fi
      echo
    elif [[ "$_FIL" = "/u00/unyo/scripts/"* ]];then
      (
        recdir=$( dirname "$_FIL" )
        echo
        echo "## mv $_FIL  $recdir/_recycle/"
        if [[ "$( inp_ok )" = 'OK' ]];then
          mkdir -p  $recdir/_recycle
          mv $_FIL  $recdir/_recycle/
        fi
      )
    else
      echo "!! $_FIL is invalid"
    fi
    #
    _FIL=$( inp_file scripts )
  done
}

###
### help
###
f_help () {
	if [[ "$BDIR" = '/u00/infra_release' ]];then
		cat <<-HELP
			
			##
			## �T�u�R�}���h
			##  status   : �w��t�H���_�ȉ��̃t�@�C���̐������`�F�b�N
			##  summary  : �e�T�[�o'scripts'�t�H���_�̐������`�F�b�N
			##  detail   : �w��T�[�o'scripts'�t�H���_�̐�����Ԃ̏ڍ�
			##
			##  ldiff    : �w��t�H���_��scripts�Ƃ̃t�@�C������
			##  rdiff    : �w��T�[�o�Ƃ̃t�@�C�����قƔz�z�\��t�@�C���̕\��
			##
			
		HELP
	else
		cat <<-HELP
			
			##
			## �T�u�R�}���h
			##  status   : �w��t�H���_�ȉ��̃t�@�C���̐������`�F�b�N
			##
			##  ldiff    : �w��t�H���_��scripts�Ƃ̃t�@�C������
			##
			
		HELP
	fi
}

f_menu () {
  local _MENU=''
  {
	typeset -i CNT=1
	typeset -i LMT=3
	while [[ "$_MENU" = '' ]];do
		read _MENU?'> '
		case $_MENU in
		  menu  )
			cat <<-MENU
				
				##
				## �T�u�R�}���h
				##  recreate : �����`�F�b�N���X�g'scripts/.checklist'�̍č\��
				##  package  : 'scripts'�t�H���_�ȉ��̃p�b�P�[�W�̍쐬
				##  install  : �p�b�P�[�W�̃C���X�g�[��
				##  rollback : 'scripts'�t�H���_�̃��[���o�b�N
				##  deploy   : �w�肵���T�[�o�ւ̃t�@�C���̔z�z
				##
				
			MENU
			CNT=1
			_MENU=''
			;;
		  '' )
			if (( LMT > CNT ));then 
			  CNT=CNT+1
			else
			  _MENU='quit'
			fi
			;;
		  
		  # for develop
		  trace ) 
			f_trace
			CNT=1
			_MENU=''
			;;
		  recycle ) 
			f_recycle
			CNT=1
			_MENU=''
			;;
		  rcpcl ) 
		    f_rcpcl
			CNT=1
			_MENU=''
			;;
		esac
	done
  } >&2
  echo $_MENU
}


###
###
### Main
###
###
_PARAM0=${1:-help}
(( $# > 0 )) && shift
_PARAMS="${@:-}"

if  tty -s;then
	_SUBCMD="$_PARAM0"
	while [[ $_SUBCMD != 'quit' ]];do
		echo "#: $_SUBCMD  $_PARAMS"
		echo
		case $_SUBCMD in
		  help    ) f_help                  ;;
		  
		  status  ) f_status   ${_PARAMS} ;;
		  summary ) f_summary  ${_PARAMS} ;;
		  detail  ) f_detail   ${_PARAMS} ;;
		  ldiff   ) f_ldiff    ${_PARAMS} ;;
		  rdiff   ) f_rdiff    ${_PARAMS} ;;

		  recreate) f_recreate ${_PARAMS} ;;
		  package ) f_package  ${_PARAMS} ;;
		  install ) f_install  ${_PARAMS} ;;
		  rollback) f_rollback ${_PARAMS} ;;
		  deploy  ) f_deploy   ${_PARAMS} ;;
		  
		  # else
		  tools   ) f_tools    ${_PARAMS} ;;
		  '!'* )
			echo "#$ ${_CMDLIN#!}"
			eval ${_CMDLIN#!}
			;;
		
		  * )
		    echo
		    echo "!!ERROR"
		    echo "!"
		    echo "! �T�u�R�}���h�������ł�: $_SUBCMD"
		    echo "!"
		    echo "!!ERROR"
		    if [[ $_PARAM0 != 'help' ]];then
		      exit 1
		    fi
		  ;;
		esac
		if [[ $_PARAM0 = 'help' ]];then
			_CMDLIN=$( f_menu )
			_SUBCMD=${_CMDLIN%% *}
			_PARAMS=${_CMDLIN#$_SUBCMD}
		else
			_SUBCMD='quit'
		fi
	done
else
	case $_PARAM0 in
	  d_status) d_status ; break ;;
	  d_output) d_output ; break ;;
	esac
fi

[ -e $ADIR/_filter.pl    ] && mv $ADIR/_filter.pl $ADIR/filter.pl
[ -e $ADIR/_diff.pl      ] && mv $ADIR/_diff.pl   $ADIR/diff.pl
[ -e $ADIR/_CRchk.sh     ] && mv $ADIR/_CRchk.sh  $ADIR/CRchk.sh
[ -e $ADIR/_target.hosts ] && rm $ADIR/_target.hosts
[ -e $BDIR/.checklist*   ] && rm $BDIR/.checklist*

exit
