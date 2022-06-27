open(IN,$ARGV[0]);
while(<IN>){
	if($_=~/^\SP\_/){
		($id)=$_=~/^(\SP\_.*?)\./;
		$id_id{$id}=$id;
	}
}
close IN;

open(FAS,$ARGV[1]);
while(<FAS>){
	chomp $_;
	if($_=~/^\>/){
		($id2)=$_=~/^\>(\SP\_.*?)\./;
	}
	elsif($_!~/^\>/){
		$id_seq{$id2}=$id_seq{$id2}.$_;
	}
}
close FAS;

open(OUT1,">$ARGV[0].prot.list");
open(OUT2,">$ARGV[0].prot.fasta");
foreach $key (keys %id_id){
	print OUT1 $key,"\n";
	print OUT2 ">",$key,"\n",$id_seq{$key},"\n";

}
close OUT1;
close OUT2;

