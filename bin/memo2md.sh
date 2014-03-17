#!/bin/sh -u
#
#	'��' -> '#'
#	'��' -> '##'
#

typeset fn=${1:-_memo.txt}

#
echo ''
echo ''

{	cat <<-'PERL'
		# ���s�R�[�h���ꉻ 
		s/\r//;

		# �s�̌p��
		s/^([^\t].+)$/$1  /;
		s/[ �@\t]*_  $/ /;

		# code-block����
		s/^#!sql/\n~~~~sql/;
		s/^#!bash/\n~~~~bash/;
		s/^#!sh/\n~~~~bash/;
		s/^#!/\n~~~~/;


		# ���X�g����
		s/^\t+\. /#. /;

		# �\����
		s/^\t/    /;
		s/\t/\|/g;

		# �w�b�_����
		s/��[ �@]*/# /;
		s/��[ �@]*/## /;
		s/��[ �@]*/### /;
		s/�E[ �@]*/###### /;
		
		__END__
	PERL
	cat $fn
} | perl -pl

exit
