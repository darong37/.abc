#!/bin/perl
use strict;
use warnings;
use Term::ANSIColor qw(:constants);

$Term::ANSIColor::AUTORESET = 0;
print RESET;

### Arguments
my ( $glsFil ) = @ARGV;

### Glass File
my $gls;
my $cmd;
open GLS,"<$glsFil" or die "not found '$glsFil'";
while(<GLS>){
  chomp;
  
  if ( /^\$ #/ ) {
    print "$_\n";
  } elsif ( /^\$ / ){
    print "$_\n";
    s/^\$ //;
    $cmd = $_;
  } else {
    $gls .= "$_\n";
  }
}
close GLS;

### Target File
$/ = undef;
open  TGT,"$cmd|" or die "command '$cmd' failed";
my $tgt = <TGT>;
close TGT;

coloredGlass($gls,$tgt);

exit;

#
# subroutine
#
sub coloredGlass {
  my ( $glass, $target ) = @_ ;   # 特殊変数からの引取り

  $glass  =~ s/\n+$/\n/;

  my $patterns = '';
  my $template = '';
  my $warn=1;      # color of next maching   0: Yellow,  else: Green

  ### Prev Syntax Sugar
  $glass =~ s/\{\n\s*/{/g;       # 行またぎ'{'
  $glass =~ s/\s*\n\s*\}/}/g;    # 行またぎ'}' 

  # 空行=Wildcard行
  $glass =~ s/\n(?:\s*\n)+([^\n{]+)/\n((?:.*\\n)+)(?=\Q$1\E)\n/g;

  $glass =~ s/\Q{*}\E/{(.*)}/g;  # {*} -> (.*)
  $glass =~ s/\Q{+}\E/{(.+)}/g;  # {+} -> (.+)
  
  $glass =~ s/\{([*+])Wait (.+)\}\n/{((?:.*\\n)$1)(?=.*\Q$2\E)}\n/g;    # {[*+]Wait *}
  
  ### Main Loop
  my $cnt=0;
  for ( split /\n/,$glass ){
    my $ptn = $_;
    my $tmp = $_;

    $cnt++;
    if ( /^\{.+\}$/ ){
      $tmp =  '%s';
      $ptn =~ s/[{}]//g;
    } elsif ( /\{\(.+?\)\}/ ) {
      $tmp =~ s/\{\(.+?\)\}/%s/g;
      $tmp .= "\n";

      # '{(' start REGEX.
      $ptn =~ s/\{\(/\\E\(/g;
      # ')}' end REGEX.
      $ptn =~ s/\)\}/\)\\Q/g;
      
      $ptn = '\Q'.$ptn.'\E\n?';
    } else {
      $tmp .= "\n";
      $ptn =  '\Q'.$ptn.'\E\n?';
    }

    if ( eval "\$target =~ m{$patterns$ptn}" ){
      $template .= $tmp;
      $patterns .= $ptn;
    } else {
      $target = printGlass( $target,$template,$patterns,$warn );

      printf "%s%s%s%s\n", RED,REVERSE,$_,RESET;
#     printf "%s%s%s\n", YELLOW,"# The avove pattern unmatched the following... ",RESET;
      $template = '%s';
      $patterns = '((?:.*\\n)+?)';
      $warn=0;
    }
  }
  $template =~ s/\n$//;
  $target = printGlass( $target,$template,$patterns,$warn );
  
  if ( $target =~ /^\s*\n*$/ ){
    printf "%s\n",RESET;
  } else {
    printf "%s\n%s",RESET,"$target";
  }
}

sub printGlass {
  my ( $target,$template,$patterns,$warn ) = @_;
  #
  my @eles = ( eval "\$target =~ m{$patterns((?:.*\\n?)+?.*)\$}" );
  if ( @eles ){
    $target = pop @eles;
  } else {
    @eles = ( '' );
  }

  if ( @eles ){
    @eles = map{ sprintf "%s%s%s", $warn++ > 0 ? GREEN : RED ,$_,BLUE } @eles;
    printf("%s$template%s", BLUE,@eles,RESET);
  } else {
    print BLUE;
    print $template;
    print RESET;
  }
  return $target;
}



