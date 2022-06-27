$id=$ARGV[0];
open(TEMP1,"temp.$id.1mu2.jaligner");
while(<TEMP1>){
	if($_=~/^Score\:/){
		($temp1_score)=$_=~/(\d+\.\d+)/;
	}
}
close TEMP1;
open(TEMP2,"temp.$id.1ra6.jaligner");
while(<TEMP2>){
        if($_=~/^Score\:/){
                ($temp2_score)=$_=~/(\d+\.\d+)/;
        }
}
close TEMP2;
open(TEMP3,"temp.$id.2xi2.jaligner");
while(<TEMP3>){
        if($_=~/^Score\:/){
                ($temp3_score)=$_=~/(\d+\.\d+)/;
        }
}
close TEMP3;
open(TEMP4,"temp.$id.4gzk.jaligner");
while(<TEMP4>){
        if($_=~/^Score\:/){
                ($temp4_score)=$_=~/(\d+\.\d+)/;
        }
}
close TEMP4;
open(TEMP5,"temp.$id.4r71.jaligner");
while(<TEMP5>){
        if($_=~/^Score\:/){
                ($temp5_score)=$_=~/(\d+\.\d+)/;
        }
}
close TEMP5;
open(TEMP6,"temp.$id.6v85.jaligner");
while(<TEMP6>){
        if($_=~/^Score\:/){
                ($temp6_score)=$_=~/(\d+\.\d+)/;
        }
}
close TEMP6;

$max_score=0;
if($temp1_score >=$max_score){
	$max_score=$temp1_score;
	$max_id="1mu2";
}
if($temp2_score >=$max_score){
        $max_score=$temp2_score;
        $max_id="1ra6";
}
if($temp3_score >=$max_score){
        $max_score=$temp3_score;
        $max_id="2xi2";
}
if($temp4_score >=$max_score){
        $max_score=$temp4_score;
        $max_id="4gzk";
}
if($temp5_score >=$max_score){
        $max_score=$temp5_score;
        $max_id="4r71";
}
if($temp6_score >=$max_score){
        $max_score=$temp6_score;
        $max_id="6v85";
}

open(OUT,">temp.$id.max_score");
print OUT $max_id,"\t",$max_score,"\n";
close OUT;

