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
export PS4='        +$LINENO	'
typeset target=${1:-};

##### Main
Hello
{
  if tty -s;then
    touch $BASEDIR/temp/$$.gls
    touch $BASEDIR/temp/$$.log
    exec 3>&0
    echo "#"
    echo "# $( id -un )@$( uname -n )"
    echo "# $$ ${PWD##$HOME/}"
    echo "#"
    while read;do
      if [[ $REPLY = '#'* ]];then
        echo "$REPLY"
      elif [[ $REPLY = '$ '* ]];then
        echo "  $REPLY"
      elif [[ $REPLY != '-> '* ]];then
        echo "$REPLY" >> $BASEDIR/temp/$$.gls
      else
        echo -n "  > "
        read CMD <&3
        
        echo "# $( date +"%H:%M:%S" )"
        echo "$ $CMD"
        if [[ $CMD = '' ]];then
          cnt=cnt+1
        else
          cnt=0
          eval "$CMD" >> $BASEDIR/temp/$$.log
          typeset -i rtn=$?
          #cat $$.log
          $APPLDIR/coloredGlass_rc.pl $BASEDIR/temp/$$.gls  $BASEDIR/temp/$$.log
          rm $BASEDIR/temp/$$.gls
          rm $BASEDIR/temp/$$.log
          
          echo "-> $rtn  $( date +"%H:%M:%S" )"
          echo
        fi
      fi
    done < $target
    exec 3>&-
  fi
} 2>&1 | tee -a $LOGFILE
Bye

##### Final
exit
