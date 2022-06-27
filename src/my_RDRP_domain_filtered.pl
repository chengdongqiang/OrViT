$score_1mu2_cutoff=$ARGV[2];
$score_cutoff=$ARGV[3];
$length_cutoff=$ARGV[4];

open(LOG,$ARGV[0]);
while(<LOG>){
	chomp $_;
	if($_ ne ""){
		@line=split(/\t/,$_);
		if($line[1] eq "1mu2" && $line[2] >= $score_1mu2_cutoff && $line[3] >= $length_cutoff){
			$id_ok{$line[0]}="ok";
		}
		elsif($line[1] ne "1mu2" && $line[2] >= $score_cutoff && $line[3] >= $length_cutoff){
			$id_ok{$line[0]}="ok";
		}
	}
}
close LOG;

open(FAS,$ARGV[1]);
while(<FAS>){
	chomp $_;
	if($_=~/^>/){
		($id)=$_=~/^>(.*)/;
		$id_id{$id}=$id;
	}
	else{
		$id_seq{$id}=$id_seq{$id}.$_;
	}
}
close FAS;

open(OUT,">$ARGV[1].filtered.fasta");
foreach my $id (keys %id_id){
	if($id_ok{$id.".fa"} eq "ok"){
		print OUT ">$id\n","$id_seq{$id}\n";
	}
}
close OUT;
