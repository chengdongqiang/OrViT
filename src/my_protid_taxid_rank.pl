open(IN,"taxid_to_rank.list");
while(<IN>){
	chomp $_;
	if($_ ne ""){
		($tid,$rank)=$_=~/^(.*)\t(.*)/;
		$rank=~s/ /_/g;
		$tid_rank{$tid}=$rank;
	}
}
close IN;

open(IN2,"protid_to_taxid.list");
open(OUT,">protid_taxid_rank.list");
while(<IN2>){
	chomp $_;
	if($_ ne ""){
		@line=split(/\t/,$_);
		print OUT $line[0],"\t",$line[1],"\t",$tid_rank{$line[1]},"\n";
	}
}
close IN2;
close OUT;
