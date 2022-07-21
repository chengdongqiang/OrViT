#NP_001012452	97.3	7.6E-11	7.6E-11	58.5	0.0	292	1-306	8-372	(380)	

open(LOG,"$ARGV[0]");
while(<LOG>){
	($motifs,$motife)=$_=~/^(.*)\t(.*)/;
}
close LOG;

open(LIST,"$ARGV[1]");
open(OUT,">$ARGV[1].checked.protid.list");
while(<LIST>){
	chomp $_;
	@line=split(/\s+/,$_);
	($s,$e)=$line[8]=~/(.*)-(.*)/;
	if($line[2]<=$ARGV[2] && $s <=$motifs && $e>=$motife){
		print OUT $line[0],"\n";
	}
}
close LIST;


