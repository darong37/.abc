#!/bin/perl
use strict;

my $TIMEOUT = 5;

print "What your name > ";
my $name = 'hoge';
eval {
  local $SIG{ALRM} = sub {die};
  alarm($TIMEOUT);
  $name = <>;
  my $timeleft = alarm(0);
};

if ($@) {
  # �^�C���A�E�g
  print "\nERROR: TIMEOUT\n";
  print "Hello! $name";
}else{
# ����I��
  print "Hello! $name";
}
