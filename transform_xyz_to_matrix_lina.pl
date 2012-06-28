#!/usr/bin/env perl

use strict;
use warnings;
use autodie qw(open close);
use Carp qw(croak);
use 5.012;

my $filename = "try";

my (@columns, %data);

open my $fh, '<', $filename; 

while (<$fh>){

	my ($row, $col, $val) = split;

	$data{$row}{$col} = $val;

	push @columns, $col;
}

@columns = sort {$a <=> $b} @columns;

#print "  @columns\n";

#for my $row (sort {$a <=> $b} keys %data){
#	print join(" ", $row, map $_? "$_":"0", @{$data{$row}}{@columns}),"\n";
#}

for my $row (sort {$a <=> $b} keys %data){
	print join(" ", map $_? "$_":"0", @{$data{$row}}{@columns}),"\n";
}
