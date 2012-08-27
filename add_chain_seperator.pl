#!/usr/bin/env perl

## add chain seperator to PDB file.
## Written by lina on 2012/08/27

use strict;
use warnings;
use autodie qw(open close);
use Carp qw(croak);
use 5.012;

my $inpdbfn="md024_0.pdb";

open my $fh, '<', $inpdbfn;

my $chain_ID=65;
my $ResID=1;

while(<$fh>){
	if(/^[^ATOM]/){

		print $_;
	}

	if(/^ATOM/){
		my @fields = split " ",$_;
		
		if($fields[4]>=$ResID){
			$ResID=$fields[4];
		}
		if($fields[4]<$ResID){
			$chain_ID+=1;
			$ResID=$fields[4];
		}
		printf("ATOM  %5d%4s%5s %c%4d    %8.3f%8.3f%8.3f%6.2f%6.2f \n",$fields[1],$fields[2],$fields[3],$chain_ID,$fields[4],$fields[5],$fields[6],$fields[7],$fields[8],$fields[9]);
	}

}

