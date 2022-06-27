#!/bin/perl
##programed by Dongqiang Cheng

open(PSI,"$ARGV[0]");
open(OUT,">$ARGV[0].fas");
while(<PSI>){
	($id,$seq)=$_=~/^(.*?)\s(\S+)/;
	print OUT ">",$id,"\n",$seq,"\n";
}
close PSI;
close OUT;
