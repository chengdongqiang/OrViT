## **OrViT: (OrthornaVirae Tree) an integrated pipeline to annotate RNA viruses**

### **Introduction**
OrViT, a pipeline that integrates and improves on two published approaches (the Starr method (Starr et al., 2019) and the Wolf method (Wolf et al., 2018)) and bridges various public software (Prodigal (Hyatt et al., 2010), HMMER (hmmer.org), JAligner (Moustafa, 2014), Mafft (Katoh and Standley, 2013), Usearch (Edgar, 2010), MUSCLE (Edgar, 2021), HHsuite (Steinegger et al., 2019), PHYLIP (Felsenstein, 2005), Modeltest-ng (Darriba et al., 2019), IQ-TREE 2 (Minh et al., 2020), and Taxonkit (Shen and Ren, 2021)) to generate a global phylogenetic tree of Orthornavirae with minimal input from the user. OrViT can be used to annotate RNA viruses from user's samples.

The novel aspect of OrViT is the ability to identify the RdRp core domain using sequences that are distantly related and from high-quality pairwise structural alignments. By excising the RdRp core motifs, the pipeline is guaranteed to produce high-quality sequence alignments and phylogenetic trees. Additionally, the integrated pipeline greatly simplifies the challenging Orthornavirae annotation analyses.

CITATION
Cheng D-Q, Kolundž ija S and Lauro FM (2022) Global phylogenetic analysis of the RNAdependent RNA polymerase with OrViT (OrthornaVirae Tree). Front. Virol. 2:981177. doi: 10.3389/fviro.2022.981177 https://doi.org/10.3389/fviro.2022.981177

### **Prerequisites**
The following software must be installed and made available in the path: curl, wget, hmmer, parallel, mafft, usearch, muscle, hhalign (with -all option), phylip (neighbor), modeltest-ng, iqtree2, taxonkit. The Java software jaligner was included in the src directory.

The GNU Make Standard Library (gmsl) was included in OrViT/src. The gmsl by John Graham-Cumming was downloaded from http://gmsl.sourceforge.net

The JAligner (Open source Java implementation of Smith-Waterman) was also included in OrViT/src. The JAligner by Ahmed Moustafa was downloaded from http://jaligner.sourceforge.net

The GNU parallel was applied for multiple serial command line parallel running. The GNU parallel by Ole Tange was cited here: Tange, O. (2021, August 22). GNU Parallel 20210822 ('Kabul'). Zenodo. https://doi.org/10.5281/zenodo.5233953.


### **Usage**
The OrViT pipeline consists of Perl and Bash scripts, assembled into a Makefile. Makefile has some default variables, such as CPU=50, IQTREE_CPU=AUTO, HMMSEARCH_E=0.01, OWNSEQ_FATOWHOLEALN_HHALIGN_E=0.01, REFSEQ_FATOWHOLEALN_HHALIGN_E=0.01, which can be specified by the user.

We recommend the use of a terminal multiplexer such as ‘screen’ to ensure the completion of the long-running task.

**OrViT.ownseq_refseq.tre**

A global tree (OrViT.ownseq_refseq.tre) based on sequences from both user’s assembled contigs and the RefSeq viral protein database can be obtained by:
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

**OrViT.refseq.tre**

The global tree (OrViT.refseq.tre) based on sequences only from the RefSeq viral protein database can be obtained by:

```
git clone https://github.com/chengdongqiang/OrViT.git
```
```
cd OrViT/src
```
```
make refseq
```

**Outputs**

The outputs will be available in OrViT/results directory. OrViT.refseq.aln and OrViT.ownseq_refseq.aln contain the multiple sequence alignments of the RdRp core domain. OrViT.refseq.tre and OrViT.ownseq_refseq.tre are the phylogenetic trees based on these alignments.


### **Examples**
**Example 1: obtaining a global tree based on sequences only from the RefSeq database**

Start a terminal multiplexer 'screen':
```
screen
```
Download OrViT pipeline:
```
git clone https://github.com/chengdongqiang/OrViT.git
```
Go to 'Makefile' containing folder:
```
cd OrViT/src
```
Run the whole pipeline with user specified parameters:
```
make refseq CPU=50
```
Detach the screen terminal session: press Control+A and Control+D.

Reattach the screen terminal session: run "screen -ls" to check the screen_session_ID, and run "screen -r screen_session_ID" to reattach.

**Example 2: user's input file as the assembly contigs are DNA sequences**

Download the assembled contigs:
```
wget -c https://zenodo.org/record/6918781/files/TARA_9samples_contigs.fasta.tar.gz
```
Uncompresses and untars the file:
```
tar -xvfz TARA_9samples_contigs.fasta.tar.gz
```
Start a terminal multiplexer 'screen':
```
screen
```
Download OrViT pipeline:
```
git clone https://github.com/chengdongqiang/OrViT.git
```
Go to 'Makefile' containing folder:
```
cd OrViT/src
```
Run the whole pipeline with user specified parameters (The path for user’s assembled contigs supposed as: ~/TARA_9samples_contigs.fasta):
```
make CONTIGS=~/TARA_9samples_contigs.fasta
```
Detach the screen terminal session: press Control+A and Control+D.

Reattach the screen terminal session: run "screen -ls" to check the screen_session_ID, and run "screen -r screen_session_ID" to reattach.

**Example 3: user's input file contains protein sequences**

We provide an example as protein sequences in the path: OrViT/examples/TARA_483samples_RdRp_canditates_cdhit09.fasta

Start a terminal multiplexer 'screen':
```
screen
```
Download OrViT pipeline:
```
git clone https://github.com/chengdongqiang/OrViT.git
```
Go to 'Makefile' containing folder:
```
cd OrViT/src
```
Run the whole pipeline with user specified parameters:
```
make CONTIGS=../examples/TARA_483samples_RdRp_canditates_cdhit09.fasta SEQTYPE=pro HMMSEARCH_E=0.05 OWNSEQ_FATOWHOLEALN_HHALIGN_E=0.05
```
Detach the screen terminal session: press Control+A and Control+D.

Reattach the screen terminal session: run "screen -ls" to check the screen_session_ID, and run "screen -r screen_session_ID" to reattach.

