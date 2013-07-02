#!/bin/sh -u
##########
#@(#) Name         : coloredGlass.sh
##########
typeset APPLDIR=$( cd $(dirname $0) && pwd )
typeset BASEDIR='..'         # �x�[�X�t�H���_��  APPLDIR����̑��΃p�X
typeset CONFDIR='conf'       # ���ݒ�t�H���_��BASEDIR����̑��΃p�X
typeset DEFENVS='common'     # include�ݒ�t�@�C����,�����w���(space���)

. $APPLDIR/$BASEDIR/$CONFDIR/defenv

##### Init
typeset target=${1:-};

export PS4='        +$LINENO	'
cd $BASEDIR

##### Main
Hello
{
  if tty -s;then
    while read;do
      if [[ $REPLY = '#'* ]];then
        echo "  $REPLY"
      elif [[ $REPLY = '$ '* ]];then
        _cmd="$REPLY"
        echo "$REPLY" >  $$.gls
      elif [[ $REPLY != '-> '* ]];then
        echo "$REPLY" >> $$.gls
      else
        echo "  #"
        echo "  # $( id -un )@$( uname -n )"
        echo "  # $$ ${PWD##$HOME/}"
        echo "  #"
        echo -n "  > "
        read CMD
        
        echo "### $( date +"%H:%M:%S" )"
        echo "$ $CMD" > $$.log
        if [[ $CMD = '' ]];then
          cnt=cnt+1
        else
          cnt=0
          eval "$CMD" >> $$.log
          typeset -i rtn=$?
          cat $$.log
          
          echo "### -> $rtn  $( date +"%H:%M:%S" )"
          echo
        fi
      fi
    done < bin/$target
  fi
} 2>&1 | tee -a $LOGFILE
Bye

##### Final
exit
