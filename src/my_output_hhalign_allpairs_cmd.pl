#perl ${SRC}/my_output_hhalign_allpairs_cmd.pl $${n} ${hhalign_M} hhalign_allpairs_cmd

$n=$ARGV[0];
$m=$ARGV[1];
open(OUT,">$ARGV[2]");
for ($i=0;$i<=$n-1;$i++){
	for ($j=$i;$j<=$n-1;$j++){
		print OUT "hhalign -i u${j}.fas -t u${i}.fas -all -glob -M ${m} -o /dev/null\n";
	}
}
close OUT;
