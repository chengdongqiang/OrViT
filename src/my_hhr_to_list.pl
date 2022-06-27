# No Hit                             Prob E-value P-value  Score    SS Cols Query HMM  Template HMM
#  1 YP_009345051                    97.3 7.6E-11 7.6E-11   58.5   0.0  292    1-306     8-372 (380)

open(HHR,$ARGV[0]);
open(OUT,">$ARGV[0].list");
while(<HHR>){
	chomp $_;
	$flag++;
	if($_=~/^Command/){
		$flag=0;
		($id)=$_=~/ \-i (.*?)\./;
	}
	elsif($flag eq 3){
		@line=split(/\s+/,$_);
		$l=@line;
		if($l eq 12){
			print OUT $id,"\t",$line[3],"\t",$line[4],"\t",$line[5],"\t",$line[6],"\t",$line[7],"\t",$line[8],"\t",$line[9],"\t",$line[10],"\t",$line[11],"\t",$line[12],"\n";
		}
	}
}
close OUT;
close HHR;

