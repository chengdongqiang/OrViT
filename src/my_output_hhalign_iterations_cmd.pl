#!/bin/perl
##programed by Dongqiang Cheng
use strict;

my $src;
my $tree;
my $node;
my $find;
my $p1;
my $p2;
my $replace;

$src=$ARGV[1];

open(TREE,$ARGV[0]);
while(<TREE>){
	chomp $_;
	if($_ ne ""){
		$tree=$tree.$_;
	}
}
close TREE;
print $tree,"\n";

open(OUT,">hhalign_iterations_cmd");
print OUT "out=\$1\n";
print OUT "source ${src}/my_hhalign.sh\n";
$node=0;
while($tree=~/^.*?\(\w+\,\w+\)/){
	print $node,"\n";
	$node++;
	($find)=$tree=~/^.*?\((\w+\,\w+)\)/;
	($p1,$p2)=$tree=~/^.*?\((\w+)\,(\w+)\)/;
	$replace="n".$node;
	$tree=~s/\($find\)/$replace/;
	print OUT "my_hhalign \"$p1\" \"$p2\" \"$replace\" \"$src\"\n";
	print "my_hhalign \"$p1\" \"$p2\" \"$replace\" \"$src\"\n";
	print "\#", $tree,"\n";
}
print OUT "cp n$node.fas \$out\n";
close OUT;
