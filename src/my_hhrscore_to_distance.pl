#!/bin/perl
##programed by Dongqiang Cheng

$cluster=$ARGV[0];

open(SCORE,"$ARGV[1]");
while(<SCORE>){
	($A,$B,$S)=$_=~/^u(.*?)\_u(.*?)\t(.*)\n/;
	$score_AB{$A."_".$B}=$S;
	if($S <= 0){
		$score_AB{$A."_".$B}=0.01;
	}
}
close SCORE;

for($i=0;$i<$cluster-1;$i++){
	$dis_AB{$i."_".$i}=0;
	for($j=$i+1;$j<$cluster;$j++){
		$dis_AB{$j."_".$j}=0;
                if($score_AB{$i."_".$j} eq "0" || $score_AB{$i."_".$j} eq "" || $score_AB{$i."_".$i} eq "0" || $score_AB{$i."_".$i} eq "" || $score_AB{$j."_".$j} eq "0" || $score_AB{$j."_".$j} eq ""){
                        print $i,"\t",$j,"\n";
                }
		$dis_AB{$i."_".$j}=(-1)*log($score_AB{$i."_".$j}/min($score_AB{$i."_".$i},$score_AB{$j."_".$j}));
	}
}


##print out hhalign_distances.matrix
#first line
open(OUT1,">hhalign_distances.matrix");
for($i=0;$i<$cluster;$i++){
	print OUT1 "\tu$i";
}
print OUT1 "\n";
#second to last lines
for($i=0;$i<$cluster;$i++){
	print OUT1 "u$i";
        for($j=0;$j<$cluster;$j++){
        	print OUT1 "\t".$dis_AB{$i."_".$j};
        }
	print OUT1 "\n";
}
close OUT1;


##print out hhalign_scores.matrix
##first line
open(OUT2,">hhalign_scores.matrix");
for($i=0;$i<$cluster;$i++){
        print OUT2 "\tu$i";
}
print OUT2 "\n";
#second to last lines
for($i=0;$i<$cluster;$i++){
	print OUT2 "u$i";
	for($j=0;$j<$cluster;$j++){
		print OUT2 "\t".$score_AB{$i."_".$j};
	}
	print OUT2 "\n";
}
close OUT2;


sub min{
	my ($a,$b)=@_;
	my $min=$a;
	if($a>$b){
		$min=$b;
	}
	return $min;
}

