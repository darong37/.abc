#!/bin/perl
use strict;
use warnings;
use Term::ANSIColor qw(:constants);

$Term::ANSIColor::AUTORESET = 0;
print RESET;

my $target = adjust('  ',<<'EOS','off');

  **********************************************************
   Welcome to Oracle $EBS 11.5.10
                  @environment (u001)
  **********************************************************
  
  
  Select your favorite enviroment: 
  1) Oracle9i
  2) Oracle8-based
  3) Applications
  Which environment would you like to maintenance?
EOS

my $srcptn = adjust('  ',<<'EOS','off');

  **********************************************************
   Welcome to Oracle $EBS {*}
                  @environment (u001)
  **********************************************************
  
  
  
  Select your favorite enviroment: 
  1) Oracle9i
  2) Oracle8-based
  3) Applications
  Which environment would you like to maintenance?
EOS

print "\n\n-- target   --\n";
print "'$target'";
print "\n--";

print "\n\n-- pattern0 --\n";
print "'$srcptn'";
print "\n--";

my $intermediate = exregex_1($srcptn);
print "\n\n-- pattern1 --\n";
print "'$intermediate'";
print "\n--";

my $patterns = exregex($srcptn);
print "\n\n-- patterns --\n";
print "'$patterns'";
print "\n--";


print "\n\n-- results  --\n";

if ( eval '$target =~ /^'.$patterns.'/x' ){
  print BLUE "Match\n";
} else {
  print RED  "Unmatch\n";
}
print RESET;

exit;

### adjust
sub adjust {
  my ( $indent,$doc,$eos ) = @_;
  #
  $doc =~ s/^$indent//g;
  $doc =~ s/\n$indent/\n/g;
  if ( $eos eq 'off' ){
    $doc =~ s/\n$//;
  }
  return $doc;
}

### exregex
sub exregex_1{
  my ( $src ) = @_;
  #
  # �s�܂���{}
  #
  $src =~ s/\n[ \t]+\n/\n\n/g;  # ��s
  $src =~ s/\n\n+/\n\n/g;       # ������s
  $src =~ s/\{[ \t\n]+/{/g;     # '{'
  $src =~ s/[ \t\n]+\}/}/g;     # '}'

  $src =~ s/(?:^|\n)(?:\n|$)/{:}/g;
  return $src;
}
sub exregex_2{
  my ( $src ) = @_;
  #
  # �s�܂���{}
  #
  $src =~ s/\n[ \t]+\n/\n\n/g;  # ��s
  $src =~ s/\n\n+/\n\n/g;       # ������s
  $src =~ s/\{[ \t\n]+/{/g;     # '{'
  $src =~ s/[ \t\n]+\}/}/g;     # '}'

  return $src;
}


sub exregex{
  my ( $src ) = @_;
  #
  # �s�܂���{}
  #
  $src =~ s/\n[ \t]+\n/\n\n/g;  # ��s
  $src =~ s/\n\n+/\n\n/g;       # ������s
  $src =~ s/\{[ \t\n]+/{/g;     # '{'
  $src =~ s/[ \t\n]+\}/}/g;     # '}'
  
  #
  my $dest='';
  my $cnt=0;
  for ( split /\n/,$src ){
    if (/^\{.+\}$/){
      #
      # {���K�\��} �s
      #
      s/^\{(.+)\}$/  $1/;
    } elsif (/^\s*$/) {
      # ��s
      $_ = '  ((?:\s*\n)+)';
    } else {
      #
      # ��ʍs
      #
      s/\$/\\E \\\$ \\Q/g;  # '$'����
      s/\@/\\E \\\@ \\Q/g;  # '@'����
      
      $_ = '\Q'.$_.'\E'." \t".'\n';
    }
#   print "$_\n";
    $dest .= "$_\n";

    #
    #last if $cnt++ > 6;
  }
  $dest .= '?';
  return $dest;
}

