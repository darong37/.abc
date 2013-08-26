#!/bin/perl
package Stxt;

use strict;
use warnings;

sub new {
  my $pkg = shift;
  my $stxtFile =  shift;
  bless {
    stxt => $stxtFile,
    host => '',
    user => '',
    logf => '',
    cmds => [],
    rtns => [],
  },$pkg;
}

sub read {
  my $self = shift;
  my $stxtFile =  $self -> {'stxt'};
  #
  open my $stxtH,"< $stxtFile" or die "can not open $stxtFile";
  $/ = undef;
  my $stxt = <$stxtH>;
  close $stxtH;
  
  #
  $stxt =~ s/^[ \t\n]+//;        # �擪�X�y�[�X
  $stxt =~ s/[ \t\n]+$//;        # �I�[�X�y�[�X
  $stxt = "\n$stxt\n";           # �擪�I�[���s�t��

  $stxt =~ s/(?<=\n)###+\n//g;
  $stxt =~ s/(?<=\n)\s*\n//g;
  $stxt =~ s/(?<=\n)[#>\$]\s*\n//g;

  $stxt =~ s/^\n//;              # �擪���s�폜
  $stxt =~ s/\n$//;              # �I�[���s�폜

  $stxt =~ s/(?<=\n)([#>\$])/\n$1/g;
  #
  my $host;
  my $user;
  my $logf;

  my @cmds;
  my @rtns;

  for my $blk (split /\n\n/,$stxt){
    if ($blk =~ /^#\@/){
      ( $host ) = $blk =~ /^#\@host: (.+)\s*$/ if $blk =~ /^#\@host: /;
      ( $user ) = $blk =~ /^#\@user: (.+)\s*$/ if $blk =~ /^#\@user: /;
      ( $logf ) = $blk =~ /^#\@logf?: (.+)\s*$/ if $blk =~ /^#\@logf?: /;
      next;
    }
    # ?
    if ($blk =~ /^#/){
      next;
    }

    my $cmd = '';
    my $rtn = '';
    for my $lin (split /\n/,$blk){
      if ( $lin =~ /^#/ ){
        $cmd .= $lin;
      } elsif ( $lin =~ /^[>\$] / ){
        $lin =~ s/^[>\$] //;
        $cmd .= $lin;
      } elsif ( $lin =~ /^_ / ){
        $lin =~ s/^_ //;
        $cmd .= "\n";
        $cmd .= $lin;
      } elsif ( $lin =~ /^\t/ ){
        $lin =~ s/^\t//;
        $rtn .= "$lin\n";
      } else {
        die "unknown lin:'$lin'";
      }
    }
    push @cmds,$cmd;
    push @rtns,$rtn;
  }
  #
  $self->{'host'} = $host;
  $self->{'user'} = $user;
  $self->{'logf'} = $logf;
  
  @{ $self->{'cmds'} } = @cmds;
  @{ $self->{'rtns'} } = @rtns;
}
1;
