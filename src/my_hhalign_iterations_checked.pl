open(CON,$ARGV[0]);
while(<CON>){
	($motifA,$motifB,$motifC)=$_=~/(D....D).*?(G...T).*?(GDD)/;
	print $motifA,"\t",$motifB,,"\t",$motifC,"\n";
	$s0=$-[0];
	$e0=$+[0];
	$s1=$-[1];
	$e1=$+[1];
	$s2=$-[2];
	$e2=$+[2];
	$s3=$-[3];
	$e3=$+[3];
}
close CON;

open(ALN,$ARGV[1]);
while(<ALN>){
	chomp $_;
	if($_=~/^>/){
		$id=$_;
	}
	else{
		$id_seq{$id}=$id_seq{$id}.$_;
	}
}
close ALN;

open(LOG,">$ARGV[1]_checked.motiflog");
print LOG $s0+1,"\t",$e0;
close LOG;

open(OUT,">$ARGV[1]_checked.fasta");
open(OUT2,">$ARGV[1]_checked.notpass.fasta");
foreach my $key (keys %id_seq){
	$seq=$id_seq{$key};
	$p1=substr($seq,$s1,1);
	$p2=substr($seq,$e1-1,1);
	$p3=substr($seq,$s2,1);
	$p4=substr($seq,$e2-1,1);
	$p5=substr($seq,$s3,1);
	$p6=substr($seq,$s3+1,1);
	$p7=substr($seq,$s3+2,1);
	if($p1 ne "-" && $p2 ne "-" && $p3 ne "-" && $p4 ne "-" && $p5 ne "-" && $p6 ne "-" && $p7 ne "-"){
		print OUT "$key\n$id_seq{$key}\n";
	}
	else{
		print OUT2 "$key\n";
	}
}
close OUT;
close OUT2;

