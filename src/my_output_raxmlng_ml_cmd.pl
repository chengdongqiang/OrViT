$msa=$ARGV[1];
$raxmlng_pars=$ARGV[2];
$prefix=$ARGV[3];
$threads=$ARGV[4];
open(CMD,">$ARGV[0]");
for($i=1;$i<=$raxmlng_pars;$i++){
	print CMD "raxml-ng --search --msa $msa --tree pars{1} --prefix ${prefix}${i} --seed ${i} --threads ${threads}\n";
}
close CMD;
