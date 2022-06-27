open(FAS,$ARGV[0]);
open(OUT,">$ARGV[1]");
while(<FAS>){
	chomp $_;
       	if($_=~/>/){
                if($firstflag eq ""){
                        print OUT $_,"\n";
                        $firstflag="ok";
                }
               	elsif($firstflag ne ""){
                        print OUT "\n",$_,"\n";
                }
        }
        else{
                print OUT $_;
        }
}
close FAS;
print OUT "\n";
close OUT;
