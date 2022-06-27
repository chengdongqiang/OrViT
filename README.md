RiViT: a pipeline for building RiboViral phylogenetic Trees

The following software dependencies must be installed and made available in the path: curl, wget, hmmer, parallel, mafft, usearch, muscle, hhalign (with -all option), phylip (neighbor), modeltest-ng, iqtree2, taxonkit. The Java software jaligner is included in the src directory.

A global tree based on sequences from both user’s assembled contigs and the RefSeq viral proteins database can be obtained by:

~$git clone https://github.com/chengdongqiang/RiViT.git

~$cd RiViT/src

~$make CONTIGS=/path/to/your/contigs.fasta

The global tree based on sequences only from the RefSeq viral proteins database can be obtained by:

~$git clone https://github.com/chengdongqiang/RiViT.git

~$cd RiViT/src

~$make refseq

The outputs will be available in RiViT/results directory. RiViT.refseq.aln and RiViT.ownseq_refseq.aln contain the multiple sequence alignments of the RdRp core domain. RiViT.refseq.tre and RiViT.ownseq_refseq.tre are the phylogenetic trees based on these alignments.

Makefile with the default option CPU=50. Users can change this parameter as their owns.

