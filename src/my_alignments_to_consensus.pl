open(ALN,$ARGV[0]);
while(<ALN>){
	chomp $_;
	if($_=~/^>/){
		$id=$_;
	}
	else{
		$id_seq{$id}=$id_seq{$id}.$_;
	}
}
close ALN;

$length=0;
foreach $key (keys %id_seq){
	if($length == 0){
		$length=length($id_seq{$key});
	}
}

open(OUT,">$ARGV[0].consensus");
for ($i=1;$i<=$length;$i++){
	foreach $key(keys %id_seq){
		$seq=$id_seq{$key};
		$aa=substr($seq,$i-1,1);
		$i_aa{$i}=$i_aa{$i}.$aa;
	}
	$countA=()=$i_aa{$i}=~/\QA/g;
	$countR=()=$i_aa{$i}=~/\QR/g;
	$countN=()=$i_aa{$i}=~/\QN/g;
        $countD=()=$i_aa{$i}=~/\QD/g;
        $countC=()=$i_aa{$i}=~/\QC/g;
        $countQ=()=$i_aa{$i}=~/\QQ/g;
        $countE=()=$i_aa{$i}=~/\QE/g;
        $countG=()=$i_aa{$i}=~/\QG/g;
        $countH=()=$i_aa{$i}=~/\QH/g;
        $countI=()=$i_aa{$i}=~/\QI/g;
        $countL=()=$i_aa{$i}=~/\QL/g;
        $countK=()=$i_aa{$i}=~/\QK/g;
        $countM=()=$i_aa{$i}=~/\QM/g;
        $countF=()=$i_aa{$i}=~/\QF/g;
        $countP=()=$i_aa{$i}=~/\QP/g;
        $countS=()=$i_aa{$i}=~/\QS/g;
        $countT=()=$i_aa{$i}=~/\QT/g;
        $countW=()=$i_aa{$i}=~/\QW/g;
        $countY=()=$i_aa{$i}=~/\QY/g;
        $countV=()=$i_aa{$i}=~/\QV/g;
        $countgap=()=$i_aa{$i}=~/\Q-/g;
	$maxc="A";
	$max=$countA;
	if ($countR >$max){
		$max=$countR;
		$maxc="R";
	}
	if ($countN >$max){
		$max=$countN;
                $maxc="N";
        }
	if ($countD >$max){
		$max=$countD;
                $maxc="D";
        }
	if ($countC >$max){
		$max=$countC;
                $maxc="C";
        }
	if ($countQ >$max){
		$max=$countQ;
                $maxc="Q";
        }
	if ($countE >$max){
		$max=$countE;
                $maxc="E";
        }
	if ($countG >$max){
		$max=$countG;
                $maxc="G";
        }
	if ($countH >$max){
		$max=$countH;
                $maxc="H";
        }
	if ($countI >$max){
		$max=$countI;
                $maxc="I";
        }
	if ($countL >$max){
		$max=$countL;
                $maxc="L";
        }
	if ($countK >$max){
		$max=$countK;
                $maxc="K";
        }
	if ($countM >$max){
		$max=$countM;
                $maxc="M";
        }
	if ($countF >$max){
		$max=$countF;
                $maxc="F";
        }
	if ($countP >$max){
		$max=$countP;
                $maxc="P";
        }
	if ($countS >$max){
		$max=$countS;
                $maxc="S";
        }
	if ($countT >$max){
		$max=$countT;
                $maxc="T";
        }
	if ($countW >$max){
		$max=$countW;
                $maxc="W";
        }
	if ($countY >$max){
		$max=$countY;
                $maxc="Y";
        }
	if ($countV >$max){
		$max=$countV;
                $maxc="V";
        }
	if ($countgap >$max){
                $maxc="-";
        }
	print OUT $maxc;
}
close OUT;
