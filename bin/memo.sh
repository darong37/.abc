#!/bin/sh -u
readonly APPLNAM=`basename $0 .sh`                # �X�N���v�g��

readonly APPLDIR=$( cd `dirname $0`;pwd )         # �X�N���v�g�i�[�ꏊ
readonly BASEDIR=$( dirname $APPLDIR )            # Base
readonly CONFDIR=$BASEDIR/conf                    # �ݒ�p�f�B���N�g��
. $APPLDIR/appl

### �t�@�C���ݒ�
readonly TRGTDIR=$BASEDIR/apps/claunch_V7/memo/log 
readonly TMPFILE=$BASEDIR/temp/memo.tmp           # �ꎞ�t�@�C��
readonly MEMOFILE=$BASEDIR/docs/memo/memo.md      # �����t�@�C��(Markdown)
readonly HTMLFILE=$BASEDIR/docs/memo/memo.html    # �����t�@�C��(html)

### 
typeset fn=${1:-}

#
### Main
if [[ $fn = '' ]];then
	:>  $TMPFILE
	for fn in $( ls -1  $TRGTDIR/*.txt  2>&- );do
		typeset bn=$( basename $fn .txt)
		typeset yyyy=${bn%????_??????}
		bn=${bn#????}
		typeset mm=${bn%??_??????}
		bn=${bn#??}
		typeset dd=${bn%_??????}
		bn=${bn#??_}
		typeset HH=${bn%????}
		bn=${bn#??}
		typeset MM=${bn%??}
		bn=${bn#??}
		typeset SS=${bn}
		echo "$( basename $fn .txt) datetime: $yyyy/$mm/$dd $HH:$MM:$SS"
		
		$APPLDIR/${APPLNAM}2md.sh $fn >> $TMPFILE

		cat >> $TMPFILE <<-HEAD
			
			> $yyyy/$mm/$dd $HH:$MM:$SS �X�V
			
			------------------
			
		HEAD
		
		cat $MEMOFILE >> $TMPFILE
		cp -p $TMPFILE $MEMOFILE
		
		mv $fn $BASEDIR/temp
	done
	
	fn=$BASEDIR/docs/memo/memo
else
	fn=${fn%.txt}
	$APPLDIR/${APPLNAM}2md.sh $fn.txt > $fn.md
fi


$APPLDIR/${APPLNAM}2html.sh $fn

exit
