#!/bin/perl
#programed by Dongqiang Cheng

open(IN,"$ARGV[0]");
open(OUT,">$ARGV[0].phylip_input");
while(<IN>){
	chomp $_;
	if($_ ne "" && $n eq ""){
		@line=split(/\t/,$_);
		$n=@line;
		print OUT "\t",$n-1,"\n";
		$j=0;
	}
	elsif($_ ne ""){
		$j++;
		@line=split(/\t/,$_);
		$id=$line[0];
		$slength=11-length($id);
		print OUT $id, " " x $slength;
		for($i=1;$i<=$n-1;$i++){
			$j_i{$j."_".$i}=$line[$i];
			if($line[$i] eq ""){
				$line[$i]=$j_i{$i."_".$j}; #i_j same as j_i
			}
			print OUT " ",$line[$i];
		}
		print OUT "\n";
	}
}
close IN;
close OUT;
