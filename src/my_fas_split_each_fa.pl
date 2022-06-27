open(FA,$ARGV[0]);
while(<FA>){
	chomp $_;
	if($_=~/^>/){
		($id)=$_=~/^>(.*)/;

	}
	else{
		$id_seq{$id}=$id_seq{$id}.$_;
	}
}
close FA;

open(LOG,">log.fas_split_each_fa.log");
foreach $key (keys %id_seq){
	if($key ne ""){
		open(OUT,">$key.fa");
		print OUT ">$key\n";
		print LOG "$key\n";
		print OUT $id_seq{$key},"\n";
		close OUT;
	}
}
close LOG;

