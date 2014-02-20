#!/bin/sh -u
readonly APPLDIR=$( cd `dirname $0`;pwd )     # �X�N���v�g�i�[�ꏊ
readonly APPLNAM=`basename $0 .sh`            # �X�N���v�g��
. $APPLDIR/appl

### �R�}���h���C��
readonly LSTFILE=${1:-$APPLDIR/$APPLNAM.lst}  # ���X�g�t�@�C��

### �ϐ�
typeset targetPath                            # ���X�g�t�@�C�����̑Ώۃt�H���_(targetPath��)
typeset fileName                              # ���X�g�t�@�C�����̑Ώۃt�@�C����(fileName��)
typeset keepDays                              # ���X�g�t�@�C�����̕ۑ�����(keepDays��)

### Main
ls $LSTFILE 1> /dev/null                      # �t�@�C�����݃`�F�b�N

###
### ���X�g�t�@�C����Ǎ���
###
typeset -i cnt=0                              # ���X�g�t�@�C���̍s�J�E���^
while read targetPath	fileName	keepDays;do
    cnt=cnt+1
	if [[ $targetPath = '#'* ]];then continue;fi
	if [[ $targetPath = ''   ]];then continue;fi

	Info ""
	Info "Line $cnt in $( basename $LSTFILE)"
	Info " 1. targetPath : $targetPath"
	Info " 2. fileName   : $fileName"
	Info " 3. keepDays   : $keepDays"
	
	### ���X�g�t�@�C���̃p�����[�^���`�F�b�N����
	if ! expr "$keepDays" + 1  1> /dev/null ;then        # keepDays�����l���ǂ����̃`�F�b�N
		ERROR "Invaild Parameter 'keepDays' in $( basename $LSTFILE)"
		exit 1
	fi

	TraceON         ### Log Trace�J�n
		cd   $targetPath
		find ./ -type f -name "$fileName" -mtime "+${keepDays}" > $TMPFILE
	TraceOFF        ### Log Trace�I��
	

	### �Ώۃt�@�C������������
	typeset target
	while read target;do
		TraceON         ### Log Trace�J�n
			RM $target
		TraceOFF        ### Log Trace�I��
	done < $TMPFILE
done < $LSTFILE

Succ "Normal End"
exit
