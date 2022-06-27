open(LIST,"$ARGV[1]");
while(<LIST>){
	chomp $_;
	if($_ ne ""){
		@line=split(/\t/,$_);
		($name)=$line[1];
		$sname=$line[0];
		$name_sname{$name}=$sname;
		print $name,"\t",$sname,"\n";
	}
}
close LIST;

open(IN,"$ARGV[0]");
open(OUT,">$ARGV[0].aln");
while(<IN>){
	chomp $_;
	if($_=~/^>/){
		($id)=$_=~/^>(\S+)/;
		if($name_sname{$id} ne ""){
			print OUT ">",$name_sname{$id},"\n";
		}
		else{
			print OUT ">",$id,"\n";
		}
	}
	else{
		print OUT $_,"\n";
	}
}
close OUT;
close IN;
