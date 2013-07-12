#!/bin/perl
use strict;
use warnings;

use Net::Telnet;
use Term::ANSIColor qw(:constants);
use Term::ReadLine;
use Tie::IxHash;

use FindBin;
use lib "$FindBin::Bin";
use eyos;

$Term::ANSIColor::AUTORESET = 0;
print RESET;


### Arguments
my ( $tlogFile ) = @ARGV;

### ReadLine
my $keyboad = new Term::ReadLine 'my_term';

### read tlog
my $hkey;
my @ele;
openR{
  if (/^#\@key: /){
    ( $hkey ) = /^#\@key: (.+)\s*$/;
    return 'next';
  }
  
  # �p�����ʍs
  $_ = "\t" if /^\t*$/;
  our $openRnext = "\t" if $openRnext =~ /^\t*$/;

  if ( /^\t$/ ){
    return 'next' if $openRnext =~ /^\t$/;
  }
  
  # �p���R�}���h�s
  if( $openRnext =~ /^_ / ){
    $openRnext =~ s/^_ /$_/;
    return 'next';
  }
  
  if ( /^\t/ ){
    # ���ʍs
    if ( $openRnext =~ /^\t/ ){
      $openRnext =~ s/^\t/$_/;
      return 'next';
    }
    push @ele,$_;
  } else {
    # �R�}���h�s
    if(/^[\$>_]\s+/ ){
      chomp;
      s/^[\$>_]\s+//;
      push @ele,$_;
    }
  }
} $tlogFile;


# Tie Hash
my %hash;
tie %hash, 'Tie::IxHash';
my $cnt=0;
while( defined $ele[$cnt] ){
  $keyboad->addhistory($ele[$cnt]) if /\S/;
  
  if ( defined $ele[$cnt+1] && $ele[$cnt+1] =~ /^\t/ ){
    $ele[$cnt+1] =~ s/^\t//;
    $hash{$ele[$cnt]} = $ele[$cnt+1];
    $cnt++;
  }
  $cnt++;
}

### TermREPL
my ( $telnet,$last ) = termRepl($hkey,'./telnet.log');

### �V�O�i������
$SIG{'INT'}  = 'Inthandler';
sub Inthandler {
  my $ok = $telnet->break;
  print STDERR "you hit break($ok)!\n";
}

while ( defined($_ = $keyboad->readline($last)) ) {
  my @result = $telnet->cmd($_);
  if ( @result ){
    $last = $telnet->last_prompt;
  } else {
    @result = auxread($telnet);
#   $last = undef;
    $last = '> ';
  }
  
  # valuation
  chomp;
  if ( defined $hash{$_} ){
    my $target = join '',@result;
    coloredGlass($hash{$_},$target);
    printf "%s",RESET;
  } else {
    print @result;
  }
}

### �ڑ��̐ؒf
$telnet->close;

=comment

=out
