#!/bin/sh -u
###
#@(#) Name         : oper/sheet.sh
###
typeset APPLDIR=$( cd $(dirname $0) && pwd )
typeset BASEDIR='../..'      # �x�[�X�t�H���_��  APPLDIR����̑��΃p�X
typeset CONFDIR='conf'       # ���ݒ�t�H���_��BASEDIR����̑��΃p�X
typeset DEFENVS=''           # include�ݒ�t�@�C����,�����w���(space���)

. $APPLDIR/$BASEDIR/$CONFDIR/defenv

exec 3>&1

###
. $APPLDIR/sheet.fnc

###
export PS4='        +$LINENO	'

###
cd $APPLDIR

Hello
{
  ##
  # Constants & Alias
  #


  ##
  # Init Check
  #
# (( $# == 0 ))                        || Die  "script requires 1 argument only"         2


  ##
  #  Arguments & Variables
  #
  _SUBCMD=${1:-repl}
  (( $# > 0 )) && shift

  ##
  # Procedures
  #
  if tty -s;then
    typeset -i cnt=0
    while(( cnt < 5 ));do
      _prompt=${PWD#$BASEDIR/}
      _prompt=${_prompt#$BASEDIR}
#     read SUB?"$_prompt> "
      echo -n "$_prompt> "
      read SUB
      if [[ $SUB = '' ]];then
        cnt=cnt+1
      else
        cnt=0
        ERROFF
          eval "$SUB"
          typeset -i rtn=$?
          echo
          echo "--> $rtn"
        ERRON
      fi
    done
  fi
} 2>&1 | tee -a $LOGFILE
Bye

##### Final
exit

