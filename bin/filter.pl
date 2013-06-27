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
