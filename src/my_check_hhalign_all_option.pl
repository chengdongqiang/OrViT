$flag="";
open(IN,"$ARGV[0]");
while(<IN>){
	if($_=~/^ -all /){
		$flag=$_;
	}
}
close IN;

if($flag ne ""){
	open(OUT,">$ARGV[1]");
	print OUT "hhalign has the -all option\n$flag\n";
	close OUT;
}
