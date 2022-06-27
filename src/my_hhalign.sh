#!/bin/bash
#programed by Dongqiang Cheng

my_hhalign () {
	hhalign -i $1.fas -t $2.fas -all -glob -v 0 -opsi $3.v1.psi
	perl $4/my_psi_to_fas.pl $3.v1.psi
	mv $3.v1.psi.fas $3.v1.fas
	hhalign -t $1.fas -i $2.fas -all -glob -v 0 -opsi $3.v2.psi
        perl $4/my_psi_to_fas.pl $3.v2.psi
        mv $3.v2.psi.fas $3.v2.fas
	f=$(perl $4/my_pickup_maxsites_hhalign_v1_v2.pl $3.v1.fas $3.v2.fas) && mv ${f} $3.fas
	#perl $4/my_seqlength_filter.pl $3.psi.fas $3.tmp 100
	#mv $3.tmp $3.fas
}

