## **OrViT: (OrthornaVirae Tree) an integrated pipeline to annotate RNA viruses**

### **Introduction**
OrViT, a pipeline that integrates and updates published methods [Starr’s method (Starr et al., 2019) and Wolf’s method (Wolf et al., 2018)] and bridges various public software [Prodigal (Hyatt et al., 2010), HMMER (hmmer.org), JAligner (Moustafa, 2014), Mafft (Katoh and Standley, 2013), Usearch (Edgar, 2010), MUSCLE (Edgar, 2021), HHsuite (Steinegger et al., 2019), PHYLIP (Felsenstein, 2005), Modeltest-ng (Darriba et al., 2019), IQ-TREE 2 (Minh et al., 2020), and Taxonkit (Shen and Ren, 2021)] to generate a global phylogenetic tree of Orthornavirae with minimal input from the user. OrViT can be used to annotate RNA viruses from user's samples.

The novelty of OrViT is in identifying RdRp core domain based on distantly-related templates which derive from high quality pairwise structural alignments. Cutting the RdRp core motifs guarentee the pipeline to obtain high quality sequence alignments and high quality phylogenetic trees. And the integrated workflow make the complex Orthornavirae annotation analyses much easier.

### **Prerequisites**
The following software dependencies must be installed and made available in the path: curl, wget, hmmer, parallel, mafft, usearch, muscle, hhalign (with -all option), phylip (neighbor), modeltest-ng, iqtree2, taxonkit. The Java software jaligner is included in the src directory.

The GNU Make Standard Library (gmsl) was included in OrViT/src. The gmsl by John Graham-Cumming was downloaded from http://gmsl.sourceforge.net

The JAligner (Open source Java implementation of Smith-Waterman) was also included in OrViT/src. The JAligner by Ahmed Moustafa was downloaded from http://jaligner.sourceforge.net 

The GNU parallel was implemented for multiple serial command line parallel running. The GNU parallel by Ole Tange was cited here: Tange, O. (2021, August 22). GNU Parallel 20210822 ('Kabul'). Zenodo. https://doi.org/10.5281/zenodo.5233953.

### **Usage**
The OrViT pipeline consists of Perl and Bash scripts, assembled into a Makefile. Makefile has set some default variables, such as CPU=50, IQTREE_CPU=AUTO, HMMSEARCH_E=0.01, OWNSEQ_FATOWHOLEALN_HHALIGN_E=0.01, REFSEQ_FATOWHOLEALN_HHALIGN_E=0.01, which can be specified by the user.

We recommend the use of a terminal multiplexer such as ‘screen’ to ensure the completion of the long-running task.

#### **OrViT.ownseq_refseq.tre**
A global tree (OrViT.ownseq_refseq.tre) based on sequences from both user’s assembled contigs and the RefSeq viral proteins database can be obtained by:
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

#### **OrViT.refseq.tre**
The global tree (OrViT.refseq.tre) based on sequences only from the RefSeq viral proteins database can be obtained by:

```
git clone https://github.com/chengdongqiang/OrViT.git
```
```
cd OrViT/src
```
```
make refseq
```

#### **Outputs**
The outputs will be available in OrViT/results directory. OrViT.refseq.aln and OrViT.ownseq_refseq.aln contain the multiple sequence alignments of the RdRp core domain. OrViT.refseq.tre and OrViT.ownseq_refseq.tre are the phylogenetic trees based on these alignments.

