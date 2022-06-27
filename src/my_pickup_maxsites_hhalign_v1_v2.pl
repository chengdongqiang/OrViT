open(FAS1,$ARGV[0]);
while(<FAS1>){
	chomp $_;
	if($_=~/^>/){
	}
	else{
		$_=~s/-//g;
		$seqlength1=$seqlength1+length($_);
	}
}
close FAS1;
open(FAS2,$ARGV[1]);
while(<FAS2>){
        chomp $_;
        if($_=~/^>/){
        }
        else{
                $_=~s/-//g;
                $seqlength2=$seqlength2+length($_);
        }
}
close FAS2;

if($seqlength2 > $seqlength1){
	print "$ARGV[1]";
}
else{
        print "$ARGV[0]";
}
