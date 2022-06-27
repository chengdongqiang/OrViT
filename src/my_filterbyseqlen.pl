$cutoff=$ARGV[1];

open(IN,"$ARGV[0]");
while(<IN>){
	chomp $_;
	if($_=~/^>/){
		$id=$_;
		$id_id{$id}=$id;
	}
	else{
		$seq=$_;
		$_=~s/-//g;
		$id_seq1{$id}=$id_seq1{$id}.$_;
		$id_seq{$id}=$id_seq{$id}.$seq;
		$id_length{$id}=length($id_seq1{$id});
	}
}
close IN;

open(OUT1,">$ARGV[0].pass$cutoff.fas");
open(OUT2,">$ARGV[0].notpass$cutoff.fas");
foreach $key (keys %id_id){
	if($id_length{$key} >= $cutoff){
		print OUT1 $key,"\n",$id_seq{$key},"\n";
	}
	else{
		print OUT2 $key,"\n",$id_seq{$key},"\n";
	}
}
close OUT1;
close OUT2;
