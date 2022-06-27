open(IN,"$ARGV[0]");
while(<IN>){
	($id)=$_=~/(.*)\.log/;
}
close IN;
print $id;
