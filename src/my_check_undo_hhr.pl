#!/bin/perl
#programed by Dongqiang Cheng

$n=$ARGV[0];
$m=$ARGV[1];
$list=$ARGV[2];

open(FINISH,"$list");
while(<FINISH>){
	($id1,$id2,$score)=$_=~/^u(.*?)\_u(.*?)\t(.*)\n/;
	$id_score{$id1."_".$id2}=$score;
}
close FINISH;

open(CMD,">hhalign_allpairs_cmd");
for($i=0;$i<=$n-1;$i++){
	for($j=$i;$j<$n;$j++){
		if($id_score{$i."_".$j} eq ""){
			print CMD "hhalign -i u${j}.fas -t u${i}.fas -glob -M $m -o /dev/null\n";
		}
	}
}
close CMD;
