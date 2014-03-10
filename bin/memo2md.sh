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
#		s/^\t+//;
		# �s�̌p��
		s/^([^\t].+)$/$1  /;
		s/[ �@\t]*_  $/ /;

		# code-block����
		s/^#!sql/~~~~sql/;
		s/^#!bash/~~~~bash/;
		s/^#!sh/~~~~bash/;
		s/^#!/~~~~/;
#		s/^#/\t#/;
#		s/^\$[ �@]/\t/;
#		s/^SQL\>[ �@]/\t/;


		# ���X�g����
		s/^\t+\. /#. /;
#		s|\t(.+)$|<pre><code>$1</code></pre>|;

		# �\
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
