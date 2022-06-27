open(IN,$ARGV[0]);
while(<IN>){
	if($_!~/^\#/){
		($id)=$_=~/^(\S+)/;
		$id_id{$id}=$id;
	}
}
close IN;

open(FAS,$ARGV[1]);
while(<FAS>){
	chomp $_;
	if($_=~/^\>/){
		($id2)=$_=~/^\>(\S+)/;
	}
	elsif($_!~/^\>/){
		$id_seq{$id2}=$id_seq{$id2}.$_;
	}
}
close FAS;

$n=0;
open(OUT1,">$ARGV[0].prot.list");
open(OUT2,">$ARGV[0].prot.newid.list");
open(OUT3,">$ARGV[0].prot.fasta");
foreach $key (keys %id_id){
	$n++;
	print OUT1 $key,"\n";
	print OUT2 $key,"\town",$n,"\n";
	print OUT3 ">own$n\n",$id_seq{$key},"\n";
}
close OUT1;
close OUT2;
close OUT3;

