open(HHR,$ARGV[0]);
open(OUT,">$ARGV[0].list");
while(<HHR>){
	$flag++;
	if($_=~/^Command/){
		$flag=0;
		($id1)=$_=~/ \-i (.*?)\./;
		($id2)=$_=~/ \-t (.*?)\./;
		$id=$id2."_".$id1;
	}
	elsif($flag eq 3){
		@line=split(/\s+/,$_);
			$l=@line;
			if($l eq 12){
				print OUT $id,"\t",$line[6],"\n";
			}
	}
}
close OUT;
close HHR;

