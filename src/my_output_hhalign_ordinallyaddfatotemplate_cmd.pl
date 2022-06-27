$target=$ARGV[2];
$src=$ARGV[3];
$output=$ARGV[5];

open(ID,"$ARGV[0]");
while(<ID>){
	chomp $_;
	if($_=~/^>/){
		($id)=$_=~/^>(\S+)/;
		$id_id{$id}=$id;
	}
}
close ID;

open(SCORE,"$ARGV[1]");
while(<SCORE>){
	@line=split(/\t/,$_);
	if($id_id{$line[0]} ne ""){
		$id_score{$line[0]}=$line[4];
	}
}
close SCORE;

$n=0;
open(OUT,">$ARGV[4]");
foreach my $key (sort {$id_score{$b} <=> $id_score{$a}} keys %id_score){
	$n++;
	$m=$n-1;
	if($n == 1){
		print OUT "hhalign -t ${key}.fa -i $target -all -glob -opsi temp$n.psi\n";
		print OUT "perl ${src}/my_psi_to_fas.pl temp$n.psi\n";
		print OUT "mv temp$n.psi.fas temp$n.fas\n";
	}
	else{
	        print OUT "hhalign -t ${key}.fa -i temp$m.fas -all -glob -opsi temp$n.psi\n";
		print OUT "perl ${src}/my_psi_to_fas.pl temp$n.psi\n";
                print OUT "mv temp$n.psi.fas temp$n.fas\n";
	}
}
print OUT "cp temp$n.fas $output\n";
close OUT;

