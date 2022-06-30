## **OrViT: a pipeline for building OrthornaVirae phylogenetic Trees**

### **Prerequisites**
The following software dependencies must be installed and made available in the path: curl, wget, hmmer, parallel, mafft, usearch, muscle, hhalign (with -all option), phylip (neighbor), modeltest-ng, iqtree2, taxonkit. The Java software jaligner is included in the src directory.

The GNU Make Standard Library (gmsl) was included in OrViT/src. The gmsl by John Graham-Cumming was downloaded from http://gmsl.sourceforge.net

The JAligner (Open source Java implementation of Smith-Waterman) was also included in OrViT/src. The JAligner by Ahmed Moustafa was downloaded from http://jaligner.sourceforge.net 

The OrViT pipeline consists of Perl and Bash scripts, assembled into a Makefile. Makefile with the default option CPU=50. Users can change this parameter as their owns.

We recommend the use of a terminal multiplexer such as ‘screen’ to ensure the completion of the long-running task.

### **Usage (build a OrViT.ownseq_refseq.tre)**
A global tree based on sequences from both user’s assembled contigs and the RefSeq viral proteins database can be obtained by:
```
git clone https://github.com/chengdongqiang/OrViT.git
```
```
cd OrViT/src
```
```
make CONTIGS=/path/to/your/contigs.fasta
```
Or user's input contigs as protein sequences:
```
make CONTIGS=/path/to/your/contigs.fasta SEQTYPE=pro
```

### **Usage (build a OrViT.refseq.tre)**
The global tree based on sequences only from the RefSeq viral proteins database can be obtained by:

```
git clone https://github.com/chengdongqiang/OrViT.git
```
```
cd OrViT/src
```
```
make refseq
```

### **Outputs**
The outputs will be available in OrViT/results directory. OrViT.refseq.aln and OrViT.ownseq_refseq.aln contain the multiple sequence alignments of the RdRp core domain. OrViT.refseq.tre and OrViT.ownseq_refseq.tre are the phylogenetic trees based on these alignments.

