#!/bin/perl
##programed by Dongqiang Cheng

open(IN,"outtree");
open(OUT,">upgma.nwk.temp0");
while(<IN>){
	chomp $_;
	print OUT $_;
}
close IN;
close OUT;

