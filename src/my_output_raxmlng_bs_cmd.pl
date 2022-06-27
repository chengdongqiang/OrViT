$msa=$ARGV[1];
$bootstrap=$ARGV[2];
$prefix=$ARGV[3];
open(CMD,">$ARGV[0]");
for($i=1;$i<=$bootstrap;$i++){
	print CMD "raxml-ng --bootstrap --msa $msa --bs-tree 1 --prefix ${prefix}${i} --seed ${i} --threads 1\n";
}
close CMD;
