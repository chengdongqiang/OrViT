$fid=$ARGV[0];
my $s;
my $e;
my $new_seq;

open(MA,"temp.$fid.max_score");
while(<MA>){
	($aln,$score)=$_=~/^(\w+)\t(\w+)/;
}
close MA;
$alnfile="temp.$fid.$aln.mafft";

open(ALN,"$alnfile");
while(<ALN>){
	chomp $_;
	if($_=~/>pdb/){
		$id="pdb";
	}
	elsif($_=~/>/){
		$id="seq";
		$id_name{'seq'}=$_;
	}
	else{
		$id_seq{$id}=$id_seq{$id}.$_;
	}
}
close ALN;

@seq=split(/------------------------------\-+/,$id_seq{'pdb'});
foreach $k (@seq){
	$j=$k;
	$k=~s/-//g;
	$l=length($k);
	if($l>$max_l){
		$max_l=$l;
		$max_j=$j;
	}
}

$id_seq{'pdb'} =~ /$max_j/;
($s,$e)=($-[0],$+[0]);
$new_seq=substr($id_seq{'seq'},$s,$e-$s);
$new_seq=~s/-//g;

open(OUT,">$fid.cut_RDRP_domain.fas");
print OUT $id_name{'seq'},"\n",$new_seq,"\n";
$len=length($new_seq);
print $fid,"\t",$aln,"\t",$score,"\t",$len,"\n";
close OUT;

