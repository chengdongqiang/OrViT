open(IN,$ARGV[0]);
open(OUT,">$ARGV[0].pick_ref.fasta");
while(<IN>){
	if($_=~/^>/){
		$flag="";
		if($_=~/^>[N|Y]P\_\d+/){
			$flag="ok";
		}
	}
	if($flag eq "ok"){
		print OUT $_;
	}
}
close IN;
close OUT;
