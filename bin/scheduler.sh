#!/bin/sh -u
readonly APPLDIR=$( cd `dirname $0`;pwd )         # �X�N���v�g�i�[�ꏊ
readonly APPLNAM=`basename $0 .sh`                # �X�N���v�g��
readonly BASEDIR=$( dirname $APPLDIR )            # Base
readonly CONFDIR=$BASEDIR/conf                    # �ݒ�p�f�B���N�g��
. $APPLDIR/appl

### �R�}���h���C��
readonly JOBGRP=$1                                # �W���u�O���[�v��
shift

### �t�@�C���ݒ�
readonly SCHTEMP=$BASEDIR/temp/${APPLNAM}.$$     # ���^�[���X�e�[�^�X�t�@�C��
readonly RTNFILE=$BASEDIR/temp/${JOBGRP}.rtn     # ���^�[���X�e�[�^�X�t�@�C��
readonly LOGFILE=$BASEDIR/logs/${JOBGRP}.log     # ���O�t�@�C��

### �ϐ�
typeset step
typeset shellName
typeset prms

##
cd $APPLDIR
(
	typeset -i rtn=0
	egrep "^$JOBGRP" $CONFDIR/schedule |
	perl  -ple "s/^$JOBGRP\s+//"       |
	sort > $SCHTEMP
	
	:> $RTNFILE
	while read step shellName prms;do
		if (( $rtn != 0 ));then
			Error "Step-$step.  Shell:'$shellName' SKIP"
			continue
		fi
		
		if [[ -r $shellName ]];then
			: > $BASEDIR/temp/$shellName.tmp

			Info  "Step-$step.  Shell:'$shellName' Start"
			./$shellName ${prms:-}
			rtn=$?

			if (( $rtn == 0 ));then
				rm $BASEDIR/temp/$shellName.tmp
			else
				Error "Step-$step.  Shell:'$shellName' ERROR Occured"
			fi
		else
			rtn=999
			Error "Step-$step.  Shell:'$shellName' can not read"
		fi
		echo "$step $shellName $rtn" >> $RTNFILE
	done < $SCHTEMP
	
	rm $SCHTEMP
	
	exit
) 2>&1 | ( #logging.pl $LOGFILE
	while read;do
		if [[ "$REPLY" != *'set +x' ]];then
			echo "$(date '+%Y/%m/%d %H:%M:%S') $REPLY"
		fi
	done
) | tee $LOGFILE
#
echo
typeset -i RTN=-999
while read step shellName RTN;do
	if (( $RTN == 0 ));then
		echo "Step-$step. $shellName: OK"
	else
		echo "Step-$step. $shellName: NG return $RTN"
		echo
		echo "# cat $LOGFILE"
		exit $RTN
	fi
done < $RTNFILE

rm -f $RTNFILE

echo
echo "# cat $LOGFILE"

