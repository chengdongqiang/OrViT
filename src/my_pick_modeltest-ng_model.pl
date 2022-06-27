#!/bin/perl
#programed by Dongqiang Cheng

open(IN,$ARGV[0]);
while(<IN>){
	#if($_=~/^  \> raxmlHPC-SSE3 /){
	#	($m)=$_=~/^  \> raxmlHPC-SSE3 .* -m (\S+) /;
	#}
	if($_=~/^  \> raxml-ng /){
		($m)=$_=~/^  \> raxml-ng .* --model (\S+)/;
	}
}
close IN;
print $m;
