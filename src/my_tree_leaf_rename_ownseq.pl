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
open(OUT,">$ARGV[0].tre");
while(<IN>){
	if($_ ne ""){
		$a=lc($_);
		foreach $key (keys(%name_sname)) {
			#$a=~s/\($key\,/\($name_sname{$key}\,/g;
			#$a=~s/\,$key\,/\,$name_sname{$key}\,/g;
			#$a=~s/\,$key\)/\,$name_sname{$key}\)/g;

			$a=~s/\($key\:/\($name_sname{$key}\:/g;
			$a=~s/\,$key\:/\,$name_sname{$key}\:/g;
		}
		print OUT $a;
	}
}
close OUT;
close IN;
