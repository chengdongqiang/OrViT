open(FAS,"$ARGV[0]");
while(<FAS>){
	chomp $_;
	if($_=~/^>/){
		($id)=$_=~/^>(.*)/;
	}
	else{
		$id_seq{$id}=$id_seq{$id}.$_;
	}
}
close FAS;

open(LIST,"$ARGV[1]");
open(OUT,">$ARGV[1].fasta");
while(<LIST>){
	chomp $_;
	print OUT ">",$_,"\n",$id_seq{$_},"\n";
}
close LIST;
close OUT;

