#!/usr/bin/env perl

use strict;
use warnings;
use autodie qw(open close);
use Carp qw(croak);
use 5.012;

my $fn = "$ARGV[0]";

#my $regexpfn = "output";

#open my $fh1, '<', $regexpfn;
#while(<$fh1>){
#	my $regexp = "$_";
#}

my $regexp = "d+";

open my $fh, '<', $fn;

my $ofh;

my $open_flag=0;

while(my $line = <$fh>){
	if($line =~ /MODEL \s+(\d+)$/){
		my $model = $1;
		$open_flag = 1;
		open $ofh, '>', "close_$model.pdb";
			
	}
	
	if($line =~ /ENDMDL/){
		$open_flag=0;
	}	
	

	if($open_flag){
		print $ofh $line;
	}

}

