#!/usr/bin/perl -nl
use strict;
use warnings;

# �t�@�C���p�[�~�b�V�����Ɋւ���萔���C���|�[�g
use Fcntl ':mode';

s/\s+$//;
s/^.+\s+//;
s/\*$//;

#printf "%-20s\t", $_;

# stat�֐��̖߂�l��3�ڂ̗v�f���t�@�C��
# �p�[�~�b�V�����̏��
my @sts = stat;

#localtime�Ō��n���Ԃɕϊ�
my($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime($sts[9]);

# ���L�҃��[�UID(���l)���烆�[�U�����擾����
my $uname = getpwuid $sts[4];

# ���L�O���[�vID(���l)����O���[�v�����擾����
my $gname = getgrgid $sts[5];

# cksum
my $chk = '';

if ( S_ISREG($sts[2]) ) {
	$chk = `cksum $_` ;
	chomp $chk;
	$chk =~ s/\s+\S+$//;
	$chk =~ s/\s+/\t/;
};

# S_IMODE�֐��Ő��l�ɕϊ�
printf "%-20s\t%03o\t%s\t%s\t%04d/%02d/%02d %02d:%02d:%02d\t$chk\n", $_, S_IMODE($sts[2]), $uname, $gname, $year+1900, $mon+1, $mday, $hour, $min, $sec;
#printf "%03o\t%s\t%s\t%04d/%02d/%02d %02d:%02d:%02d\t$chk\n", S_IMODE($sts[2]), $uname, $gname, $year+1900, $mon+1, $mday, $hour, $min, $sec;

