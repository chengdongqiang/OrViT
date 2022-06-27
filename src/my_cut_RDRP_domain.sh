src=$1
input=$2
logoutput=$3

jaligner(){
	java -jar ${src}/jaligner.jar ${src}/1mu2.fas $1 BLOSUM62 10.0 0.5 >temp.$1.1mu2.jaligner
        java -jar ${src}/jaligner.jar ${src}/1ra6.fas $1 BLOSUM62 10.0 0.5 >temp.$1.1ra6.jaligner
        java -jar ${src}/jaligner.jar ${src}/2xi2.fas $1 BLOSUM62 10.0 0.5 >temp.$1.2xi2.jaligner
        java -jar ${src}/jaligner.jar ${src}/2xi2.fas $1 BLOSUM62 10.0 0.5 >temp.$1.2xi2.jaligner
        java -jar ${src}/jaligner.jar ${src}/4gzk.fas $1 BLOSUM62 10.0 0.5 >temp.$1.4gzk.jaligner
        java -jar ${src}/jaligner.jar ${src}/4r71.fas $1 BLOSUM62 10.0 0.5 >temp.$1.4r71.jaligner
        java -jar ${src}/jaligner.jar ${src}/6v85.fas $1 BLOSUM62 10.0 0.5 >temp.$1.6v85.jaligner

	cat ${src}/1mu2.fas $1 >temp.$1.1mu2.faa
	cat ${src}/1ra6.fas $1 >temp.$1.1ra6.faa
	cat ${src}/2xi2.fas $1 >temp.$1.2xi2.faa
	cat ${src}/4gzk.fas $1 >temp.$1.4gzk.faa
	cat ${src}/4r71.fas $1 >temp.$1.4r71.faa
	cat ${src}/6v85.fas $1 >temp.$1.6v85.faa

	mafft --maxiterate 1000 --localpair --quiet temp.$1.1mu2.faa > temp.$1.1mu2.mafft
        mafft --maxiterate 1000 --localpair --quiet temp.$1.1ra6.faa > temp.$1.1ra6.mafft
        mafft --maxiterate 1000 --localpair --quiet temp.$1.2xi2.faa > temp.$1.2xi2.mafft
        mafft --maxiterate 1000 --localpair --quiet temp.$1.4gzk.faa > temp.$1.4gzk.mafft
        mafft --maxiterate 1000 --localpair --quiet temp.$1.4r71.faa > temp.$1.4r71.mafft
        mafft --maxiterate 1000 --localpair --quiet temp.$1.6v85.faa > temp.$1.6v85.mafft

	perl ${src}/my_pick_max_score_jaligner.pl $1
	perl ${src}/my_cut_RDRP_domain.pl $1 >>${logoutput}

	rm temp.$1.*
}

while read p
do
	jaligner ${p}.fa
	rm ${p}.fa
done <${input}

