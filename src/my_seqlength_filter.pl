$length_cutoff=$ARGV[2];
open(IN,$ARGV[0]);
open(OUT,">$ARGV[1]");
while(<IN>){
	chomp $_;
	if($_=~/^>/){
		$id=$_;
	}
	else{
		$seq=$_;
		$_=~s/\-//g;
		$seqlength=length($_);
		if($seqlength >= $length_cutoff){
			print OUT $id,"\n",$seq,"\n";
		}
	}
}
print OUT "\n";
close IN;
close OUT;

