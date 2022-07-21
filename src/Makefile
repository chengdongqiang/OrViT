###OrViT, a pipeline that integrate and update published methods [Starr’s method (Starr et al., 2019) and Wolf’s method (Wolf et al., 2018)] and bridge various public software [Prodigal (Hyatt et al., 2010), HMMER (hmmer.org), JAligner (Moustafa, 2014), Mafft (Katoh and Standley, 2013), Usearch (Edgar, 2010), MUSCLE (Edgar, 2021), HHsuite (Steinegger et al., 2019), PHYLIP (Felsenstein, 2005), Modeltest-ng (Darriba et al., 2019), IQ-TREE 2 (Minh et al., 2020), and Taxonkit (Shen and Ren, 2021)] to generates a global phylogenetic tree of all Orthornavirae with minimal input from the user.
###This pipeline will output the OrthornaVirae phylogenetic Tree (OrViT.refseq.tre or OrViT.ownseq_refseq.tre) and the multiple sequences alignments of RdRp core domain (OrViT.refseq.aln or OrViT.ownseq_refseq.aln) using sequences from RefSeq viral proteins database and the user's assembled contigs.
###Dong-Qiang Cheng (Email: chengdongqiang@gmail.com), Federico M. Lauro (Email: flauro@ntu.edu.sg)

### GNU Make Standard Library (gmsl) by John Graham-Cumming was downloaded from http://gmsl.sourceforge.net -- put both gmsl and __gmsl in the same directory
include gmsl
### JAligner (Open source Java implementation of Smith-Waterman) by Ahmed Moustafa was downloaded from http://jaligner.sourceforge.net 

CPU := 50

HMMSEARCH_E := 0.01
USEARCH_ID := 0.5
HHALIGN_M := 67
1MU2_JALIGNER_SCORE_CUTOFF := 200
OTHERPDB_JALIGNER_SCORE_CUTOFF := 100
CUTDOMAIN_LENGTH_CUTOFF := 220
REFSEQ_FATOWHOLEALN_HHALIGN_E := 0.01
OWNSEQ_FATOWHOLEALN_HHALIGN_E := 0.01

IQTREE_PARAMETERS := --alrt 2000 -B 2000 --nmax 2000

SRC := ../src
RESULTS := ../results
CONTIGS := ../results/own_contigs.fasta
SEQTYPE := nuc

#prerequisite installations: curl wget hmmer parallel mafft usearch muscle hhalign phylip(neighbor) prodigal modeltest-ng iqtree2 usearch taxonkit jaligner(java)
##install taxonkit
#wget -c https://github.com/shenwei356/taxonkit/releases/download/v0.10.1/taxonkit_linux_amd64.tar.gz
#tar xvfz taxonkit_linux_amd64.tar.gz
#wget -c ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
#tar -zxvf taxdump.tar.gz
#mkdir -p $HOME/.taxonkit
#cp names.dmp nodes.dmp delnodes.dmp merged.dmp $HOME/.taxonkit
REQUIRED_CMDS := bash perl test gunzip parallel curl wget hmmsearch hmmconvert mafft usearch muscle hhalign phylip modeltest-ng iqtree2 taxonkit prodigal java
$(foreach cmd,$(REQUIRED_CMDS),$(if $(shell command -v $(cmd) 2> /dev/null),$(info Found `$(cmd)`),$(error Please install `$(cmd)`) command))

#PF03431	RNA_replicase_B
#PF00946	Mononeg_RNA_pol
#PF07925	RdRP_5
#PF00972	Flavi_NS5
#PF04196	Bunya_RdRp
#PF05919	Mitovir_RNA_pol
#PF00680	RdRP_1
#PF00978	RdRP_2
#PF00998	RdRP_3
#PF02123	RdRP_4
#PF00078	RVT_1
#PF07727	RVT_2
#PF04197	Birna_RdRp
#Cystoviridae
HMMS := PF03431 PF00946 PF07925 PF00972 PF04196 PF05919 PF00680 PF00978 PF00998 PF02123 PF00078 PF07727 PF04197
HMMFILES := $(patsubst %,$(RESULTS)/%_convert.hmm,$(HMMS))

#################################################################################################################################
.PHONY : all
all : CommandsCheck $(RESULTS)/own_contigs.fasta $(RESULTS)/OrViT.ownseq_refseq.tre

.PHONY : refseq
refseq : CommandsCheck $(RESULTS)/OrViT.refseq.tre
#################################################################################################################################

# OwnseqRefseqTreeLeafRename

$(RESULTS)/OrViT.ownseq_refseq.tre : $(RESULTS)/own_ref_hhalign.fasta_checked.fasta.tre $(RESULTS)/protid_taxid_rank.list
	cd $(RESULTS) && perl $(SRC)/my_tree_leaf_rename.pl own_ref_hhalign.fasta_checked.fasta.tre protid_taxid_rank.list
	cd $(RESULTS) && perl $(SRC)/my_tree_leaf_rename_ownseq.pl own_ref_hhalign.fasta_checked.fasta.tre.tre own_hmmsearch_tblout.prot.newid.list
	cd $(RESULTS) && cp own_ref_hhalign.fasta_checked.fasta.tre.tre.tre OrViT.ownseq_refseq.tre

#OwnseqRefseqPhylogenyTree

$(RESULTS)/own_ref_hhalign.fasta_checked.fasta.tre : $(RESULTS)/own_ref_hhalign.fasta_checked.fasta.iqtree2.tre
	cd $(RESULTS) && cp own_ref_hhalign.fasta_checked.fasta.iqtree2.tre own_ref_hhalign.fasta_checked.fasta.tre

$(RESULTS)/own_ref_hhalign.fasta_checked.fasta.iqtree2.tre : $(RESULTS)/own_ref_hhalign.fasta_checked.fasta
	cd $(RESULTS) && modeltest-ng -p $(CPU) -d aa -t mp -T raxml --force -i own_ref_hhalign.fasta_checked.fasta
	cd $(RESULTS) && model=$$(perl $(SRC)/my_pick_modeltest-ng_iqtree.pl own_ref_hhalign.fasta_checked.fasta.out) && iqtree2 -s own_ref_hhalign.fasta_checked.fasta -m $${model} $(IQTREE_PARAMETERS) -T AUTO
	cd $(RESULTS) && cp own_ref_hhalign.fasta_checked.fasta.treefile own_ref_hhalign.fasta_checked.fasta.iqtree2.tre

# OwnseqAlnToRefseq

$(RESULTS)/own_ref_hhalign.fasta_checked.fasta : $(RESULTS)/own_ref_hhalign.fasta
	cd $(RESULTS) && perl $(SRC)/my_alignments_to_consensus.pl own_ref_hhalign.fasta
	cd $(RESULTS) && perl $(SRC)/my_hhalign_iterations_checked.pl own_ref_hhalign.fasta.consensus own_ref_hhalign.fasta
	cd $(RESULTS) && perl $(SRC)/my_aln_id_rename_ownseq.pl own_ref_hhalign.fasta_checked.fasta own_hmmsearch_tblout.prot.newid.list
	cd $(RESULTS) && cp own_ref_hhalign.fasta_checked.fasta.aln OrViT.ownseq_refseq.aln

$(RESULTS)/own_ref_hhalign.fasta : $(RESULTS)/own.eachfatotemplate.hhr.list $(RESULTS)/own_RDRP_domain.fasta.motifchecked.fasta
	cd $(RESULTS) && perl $(SRC)/my_fas_split_each_fa.pl own_RDRP_domain.fasta.motifchecked.fasta
	cd $(RESULTS) && perl $(SRC)/my_output_hhalign_ordinallyaddfatotemplate_cmd.pl own_RDRP_domain.fasta.motifchecked.fasta own.eachfatotemplate.hhr.list ref_hhalign.fasta_checked.fasta $(SRC) hhalign_ownseqtorefseq_cmd own_ref_hhalign.fasta
	cd $(RESULTS) && bash hhalign_ownseqtorefseq_cmd
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.fa" -exec rm {} + && find . -type f -name "temp*.fas" -exec rm {} + && find . -type f -name "temp*.psi" -exec rm {} + && find . -type f -name "*.hhr" -exec rm {} + && rm hhalign_ownseqtorefseq_cmd log.fas_split_each_fa.log

# OwnseqRDRPDomainMotifCheck

$(RESULTS)/own_RDRP_domain.fasta.motifchecked.fasta : $(RESULTS)/own.eachfatotemplate.hhr.list $(RESULTS)/ref_hhalign.fasta_checked.fasta
	cd $(RESULTS) && perl $(SRC)/my_hhrlist_check.pl ref_hhalign.fasta_checked.motiflog own.eachfatotemplate.hhr.list $(OWNSEQ_FATOWHOLEALN_HHALIGN_E)
	cd $(RESULTS) && perl $(SRC)/my_checked_protid_to_fas.pl own_RDRP_domain.fasta own.eachfatotemplate.hhr.list.checked.protid.list
	cd $(RESULTS) && mv own.eachfatotemplate.hhr.list.checked.protid.list.fasta own_RDRP_domain.fasta.motifchecked.fasta
	cd $(RESULTS) && sleep 10 && rm own.eachfatotemplate.hhr.list.checked.protid.list

$(RESULTS)/own.eachfatotemplate.hhr.list : $(RESULTS)/own_RDRP_domain.fasta $(RESULTS)/ref_hhalign.fasta_checked.fasta
	cd $(RESULTS) && perl $(SRC)/my_fas_split_each_fa.pl own_RDRP_domain.fasta
	cd $(RESULTS) && bash $(SRC)/my_output_hhalign_eachfatotemplate_cmd.sh ref_hhalign.fasta_checked.fasta
	cd $(RESULTS) && l=$$(wc -l hhalign_eachfatotemplate_cmd | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n hhalign_eachfatotemplate_cmd split && ls split* >list
	cd $(RESULTS) && parallel -j$(CPU) bash {} ">" {}.hhr :::: list
	cd $(RESULTS) && sleep 10 && cat split*.hhr >own.eachfatotemplate.hhr
	cd $(RESULTS) && perl $(SRC)/my_hhr_to_list.pl own.eachfatotemplate.hhr
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.fa" -exec rm {} + && rm hhalign_eachfatotemplate_cmd split* list log.fas_split_each_fa.log own.eachfatotemplate.hhr

# OwnseqCutRDRPDomain

$(RESULTS)/own_RDRP_domain.fasta : $(RESULTS)/own_hmmsearch_tblout.prot.fasta
	cd $(RESULTS) && perl ${SRC}/my_fas_split_each_fa.pl own_hmmsearch_tblout.prot.fasta
	cd $(RESULTS) && l=$$(wc -l log.fas_split_each_fa.log | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n log.fas_split_each_fa.log split && ls split* >list
	cd $(RESULTS) && echo "RefseqID	BestJalignerPDBID	BestJalignerScore	CutDomainLength">own_log.jaligner.log && parallel -j$(CPU) bash $(SRC)/my_cut_RDRP_domain.sh $(SRC) {} own_log.jaligner.log :::: list
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.cut_RDRP_domain.fas" -exec cat {} + >own_RDRP_domain.fasta
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.cut_RDRP_domain.fas" -exec rm {} + && rm split* list log.fas_split_each_fa.log


# OwnseqStarrMethod

$(RESULTS)/own_hmmsearch_tblout.prot.fasta : $(RESULTS)/all.hmm $(RESULTS)/own_proteins.fasta
	cd $(RESULTS) && hmmsearch -o own_hmmsearch_out --tblout own_hmmsearch_tblout --cpu $(CPU) -E $(HMMSEARCH_E) all.hmm own_proteins.fasta
	cd $(RESULTS) && perl $(SRC)/my_own_hmmsearch_tblout_id_to_fas.pl own_hmmsearch_tblout own_proteins.fasta
	cd $(RESULTS) && sleep 10 && rm own_hmmsearch_out own_hmmsearch_tblout

# OwnProteins

ifeq ($(SEQTYPE),nuc)
$(RESULTS)/own_proteins.fasta : $(RESULTS)/own_nuc
else
$(RESULTS)/own_proteins.fasta : $(RESULTS)/own_pro
endif

$(RESULTS)/own_nuc :  $(RESULTS)/own_contigs.fasta
	cd $(RESULTS) && l=$$(wc -l own_contigs.fasta| cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+2)) && split -l $$n own_contigs.fasta split && ls split* >list
	cd $(RESULTS) && parallel -j$(CPU) prodigal -i {} -o {}.prodigal.gbk -a {}.prodigal_proteins.fas -d {}.prodigal_genes.fas -p meta :::: list
	cd $(RESULTS) && sleep 10 && cat split*.prodigal_proteins.fas >own_proteins.fasta && cat split*.prodigal.gbk >own_proteins.gbk && cat split*.prodigal_genes.fas >own_proteins.genes.fasta
	cd $(RESULTS) && sleep 10 && touch own_nuc && rm split* list

$(RESULTS)/own_pro : $(RESULTS)/own_contigs.fasta
	cd $(RESULTS) && cp own_contigs.fasta own_proteins.fasta
	cd $(RESULTS) && sleep 10 && touch own_pro

$(RESULTS)/own_contigs.fasta : | $(RESULTS)
	@cd $(RESULTS) && test -s $(CONTIGS) || { echo "CONTIGS file path not correct! Exiting... Usage: make CONTIGS=/path/to/your/contigs.fasta or make CONTIGS=/path/to/your/contigs.fasta SEQTYPE=pro"; exit 1; }
	cd $(RESULTS) && perl $(SRC)/my_fastooneline.pl $(CONTIGS) own_contigs.fasta

# RefseqTreeLeafRename

$(RESULTS)/OrViT.refseq.tre : $(RESULTS)/ref_hhalign.fasta_checked.fasta.tre $(RESULTS)/protid_taxid_rank.list
	cd $(RESULTS) && perl $(SRC)/my_tree_leaf_rename.pl ref_hhalign.fasta_checked.fasta.tre protid_taxid_rank.list
	cd $(RESULTS) && cp ref_hhalign.fasta_checked.fasta.tre.tre OrViT.refseq.tre

# RefseqAnnotation

$(RESULTS)/protid_taxid_rank.list : $(RESULTS)/refseq_hmmsearch_tblout.prot.fasta
	cd $(RESULTS) && curl -O ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.FULL.gz
	cd $(RESULTS) && gunzip prot.accession2taxid.FULL.gz
	cd $(RESULTS) && cp refseq_hmmsearch_tblout.prot.list protid.list
	cd $(RESULTS) && l=$$(wc -l protid.list | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n protid.list split && ls split* >list
	cd $(RESULTS) && echo >protid_to_taxid.list && parallel -j$(CPU) bash $(SRC)/my_protid_to_taxid.sh {} :::: list
	cd $(RESULTS) && awk -F '\t' '{print $$2}' protid_to_taxid.list | taxonkit reformat -I 1 -f "{k}|{p}|{c}|{o}|{f}|{g}|{s}" >taxid_to_rank.list
	cd $(RESULTS) && perl $(SRC)/my_protid_taxid_rank.pl
	cd $(RESULTS) && sleep 10 && rm split* list prot.accession2taxid.FULL protid.list protid_to_taxid.list taxid_to_rank.list

# RefseqPhylogenyTree

$(RESULTS)/ref_hhalign.fasta_checked.fasta.tre : $(RESULTS)/ref_hhalign.fasta_checked.fasta.iqtree2.tre
	cd $(RESULTS) && cp ref_hhalign.fasta_checked.fasta.iqtree2.tre ref_hhalign.fasta_checked.fasta.tre

$(RESULTS)/ref_hhalign.fasta_checked.fasta.iqtree2.tre : $(RESULTS)/ref_hhalign.fasta_checked.fasta
	cd $(RESULTS) && modeltest-ng -p $(CPU) -d aa -t mp -T raxml --force -i ref_hhalign.fasta_checked.fasta
	cd $(RESULTS) && model=$$(perl $(SRC)/my_pick_modeltest-ng_iqtree.pl ref_hhalign.fasta_checked.fasta.out) && iqtree2 -s ref_hhalign.fasta_checked.fasta -m $${model} $(IQTREE_PARAMETERS) -T AUTO
	cd $(RESULTS) && cp ref_hhalign.fasta_checked.fasta.treefile ref_hhalign.fasta_checked.fasta.iqtree2.tre

# RefseqAlnNotPassedFas

$(RESULTS)/ref_hhalign.fasta_checked.fasta : $(RESULTS)/ref_hhalign.fasta
	cd $(RESULTS) && perl $(SRC)/my_alignments_to_consensus.pl ref_hhalign.fasta
	cd $(RESULTS) && perl $(SRC)/my_hhalign_iterations_checked.pl ref_hhalign.fasta.consensus ref_hhalign.fasta
	cd $(RESULTS) && cp ref_hhalign.fasta_checked.fasta OrViT.refseq.aln

$(RESULTS)/ref_hhalign.fasta : $(RESULTS)/r2.eachfatotemplate.hhr.list
	cd $(RESULTS) && perl $(SRC)/my_fas_split_each_fa.pl refseq_RDRP_domain.fasta
	cd $(RESULTS) && perl $(SRC)/my_output_hhalign_ordinallyaddfatotemplate_cmd.pl r2.hhalign_iterations.fasta_checked.notpass.fasta r2.eachfatotemplate.hhr.list r2.hhalign_iterations.fasta_checked.fasta $(SRC) hhalign_notpassedfatotemplate_cmd ref_hhalign.fasta
	cd $(RESULTS) && bash hhalign_notpassedfatotemplate_cmd
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.fa" -exec rm {} + && find . -type f -name "temp*.fas" -exec rm {} + && find . -type f -name "temp*.psi" -exec rm {} + && find . -type f -name "*.hhr" -exec rm {} + && rm hhalign_notpassedfatotemplate_cmd log.fas_split_each_fa.log

$(RESULTS)/r2.eachfatotemplate.hhr.list : $(RESULTS)/refseq_RDRP_domain.fasta $(RESULTS)/r2.hhalign_iterations.fasta_checked.fasta
	cd $(RESULTS) && perl $(SRC)/my_fas_split_each_fa.pl refseq_RDRP_domain.fasta
	cd $(RESULTS) && bash $(SRC)/my_output_hhalign_eachfatotemplate_cmd.sh r2.hhalign_iterations.fasta_checked.fasta
	cd $(RESULTS) && l=$$(wc -l hhalign_eachfatotemplate_cmd | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n hhalign_eachfatotemplate_cmd split && ls split* >list
	cd $(RESULTS) && parallel -j$(CPU) bash {} ">" {}.hhr :::: list
	cd $(RESULTS) && sleep 10 && cat split*.hhr >r2.eachfatotemplate.hhr
	cd $(RESULTS) && perl $(SRC)/my_hhr_to_list.pl r2.eachfatotemplate.hhr
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.fa" -exec rm {} + && && rm hhalign_eachfatotemplate_cmd split* list log.fas_split_each_fa.log r2.eachfatotemplate.hhr

# Refseq.r2.WolfMethod

$(RESULTS)/r2.hhalign_iterations.fasta_checked.fasta : $(RESULTS)/r2.hhalign_iterations.fasta
	cd $(RESULTS) && perl $(SRC)/my_alignments_to_consensus.pl r2.hhalign_iterations.fasta
	cd $(RESULTS) && perl $(SRC)/my_hhalign_iterations_checked.pl r2.hhalign_iterations.fasta.consensus r2.hhalign_iterations.fasta

$(RESULTS)/r2.hhalign_iterations.fasta : $(RESULTS)/r2.upgma.nwk
	cd $(RESULTS) && perl $(SRC)/my_output_hhalign_iterations_cmd.pl r2.upgma.nwk $(SRC)
	cd $(RESULTS) && bash hhalign_iterations_cmd r2.hhalign_iterations.fasta
	cd $(RESULTS) && sleep 10 && find . -type f -name "n*" -exec rm {} + && find . -type f -name "u*.hhr" -exec rm {} + && find . -type f -name "u*.fas" -exec rm {} + && rm hhalign_iterations_cmd

$(RESULTS)/r2.upgma.nwk : $(RESULTS)/r2.all.hhr.list
	cd $(RESULTS) && n=$$(ls u*.fas | wc -l) && perl $(SRC)/my_hhrscore_to_distance.pl $$n r2.all.hhr.list
	cd $(RESULTS) && perl $(SRC)/my_distance_to_phylip_input.pl hhalign_distances.matrix
	cd $(RESULTS) && phylip neighbor <$(SRC)/my_neighbor_parameter
	cd $(RESULTS) && perl $(SRC)/my_tree_to_oneline.pl
	cd $(RESULTS) && cat upgma.nwk.temp0 | perl -p -i -e 's/:(\d+\.\d+)(\,)/\,/g' >upgma.nwk.temp1
	cd $(RESULTS) && cat upgma.nwk.temp1 | perl -p -i -e 's/:(\d+\.\d+)(\))/\)/g' >upgma.nwk.temp2
	cd $(RESULTS) && cat upgma.nwk.temp2 | perl -p -i -e 's/:(\-\d+\.\d+)(\,)/\,/g' >upgma.nwk.temp3
	cd $(RESULTS) && cat upgma.nwk.temp3 | perl -p -i -e 's/:(\-\d+\.\d+)(\))/\)/g' >upgma.nwk.temp4
	cd $(RESULTS) && sleep 10 && mv upgma.nwk.temp4 r2.upgma.nwk && rm hhalign_scores.matrix hhalign_distances.matrix hhalign_distances.matrix.phylip_input upgma.nwk.temp* outfile outtree

$(RESULTS)/r2.all.hhr.list : $(RESULTS)/r2.log.usearch_muscle.log
	cd $(RESULTS) && n=$$(ls u*.fas | wc -l) && perl $(SRC)/my_output_hhalign_allpairs_cmd.pl $$n $(HHALIGN_M) hhalign_allpairs_cmd
	cd $(RESULTS) && l=$$(wc -l hhalign_allpairs_cmd | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n hhalign_allpairs_cmd split && ls split* >list
	cd $(RESULTS) && parallel -j$(CPU) bash {} ">" {}.hhr :::: list
	cd $(RESULTS) && sleep 10 && cat split*.hhr >r2.all.hhr
	cd $(RESULTS) && perl $(SRC)/my_hhrscore_to_list.pl r2.all.hhr
	cd $(RESULTS) && n=$$(ls u*.fas | wc -l) && perl $(SRC)/my_check_undo_hhr.pl $$n $(HHALIGN_M) r2.all.hhr.list
	cd $(RESULTS) && bash hhalign_allpairs_cmd >r2.new.hhr
	cd $(RESULTS) && cat r2.all.hhr r2.new.hhr >r2.all.new.hhr
	cd $(RESULTS) && perl $(SRC)/my_hhrscore_to_list.pl r2.all.new.hhr
	cd $(RESULTS) && mv r2.all.new.hhr.list r2.all.hhr.list
	cd $(RESULTS) && sleep 10 && rm split* list hhalign_allpairs_cmd r2.all.hhr r2.new.hhr r2.all.new.hhr

$(RESULTS)/r2.log.usearch_muscle.log : $(RESULTS)/refseq_RDRP_domain.fasta.motifchecked.fasta
	cd $(RESULTS) && usearch -cluster_fast refseq_RDRP_domain.fasta.motifchecked.fasta -id $(USEARCH_ID) -msaout u
	cd $(RESULTS) && for i in u*;do mv $$i ./$${i}.fa;done
	-cd $(RESULTS) && for i in u*.fa;do muscle -align $${i} -output $${i}s --threads $(CPU);done
	cd $(RESULTS) && sleep 10 && find . -type f -name "u*.fas" -exec ls {} + >r2.log.usearch_muscle.log && find . -type f -name "u*.fa" -exec rm {} +

# RefseqRDRPDomainMotifCheck

$(RESULTS)/refseq_RDRP_domain.fasta.motifchecked.fasta : $(RESULTS)/r1.eachfatotemplate.hhr.list $(RESULTS)/r1.hhalign_iterations.fasta_checked.fasta
	cd $(RESULTS) && perl $(SRC)/my_hhrlist_check.pl r1.hhalign_iterations.fasta_checked.motiflog r1.eachfatotemplate.hhr.list $(REFSEQ_FATOWHOLEALN_HHALIGN_E)
	cd $(RESULTS) && perl $(SRC)/my_checked_protid_to_fas.pl refseq_RDRP_domain.fasta r1.eachfatotemplate.hhr.list.checked.protid.list
	cd $(RESULTS) && mv r1.eachfatotemplate.hhr.list.checked.protid.list.fasta refseq_RDRP_domain.fasta.motifchecked.fasta
	cd $(RESULTS) && sleep 10 && rm r1.eachfatotemplate.hhr.list.checked.protid.list

$(RESULTS)/r1.eachfatotemplate.hhr.list : $(RESULTS)/refseq_RDRP_domain.fasta $(RESULTS)/r1.hhalign_iterations.fasta_checked.fasta
	cd $(RESULTS) && perl $(SRC)/my_fas_split_each_fa.pl refseq_RDRP_domain.fasta
	cd $(RESULTS) && bash $(SRC)/my_output_hhalign_eachfatotemplate_cmd.sh r1.hhalign_iterations.fasta_checked.fasta
	cd $(RESULTS) && l=$$(wc -l hhalign_eachfatotemplate_cmd | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n hhalign_eachfatotemplate_cmd split && ls split* >list
	cd $(RESULTS) && parallel -j$(CPU) bash {} ">" {}.hhr :::: list
	cd $(RESULTS) && sleep 10 && cat split*.hhr >r1.eachfatotemplate.hhr
	cd $(RESULTS) && perl $(SRC)/my_hhr_to_list.pl r1.eachfatotemplate.hhr
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.fa" -exec rm {} + && rm hhalign_eachfatotemplate_cmd split* list log.fas_split_each_fa.log r1.eachfatotemplate.hhr

# Refseq.r1.WolfMethod

$(RESULTS)/r1.hhalign_iterations.fasta_checked.fasta : $(RESULTS)/r1.hhalign_iterations.fasta
	cd $(RESULTS) && perl $(SRC)/my_alignments_to_consensus.pl r1.hhalign_iterations.fasta
	cd $(RESULTS) && perl $(SRC)/my_hhalign_iterations_checked.pl r1.hhalign_iterations.fasta.consensus r1.hhalign_iterations.fasta

$(RESULTS)/r1.hhalign_iterations.fasta : $(RESULTS)/r1.upgma.nwk
	cd $(RESULTS) && perl $(SRC)/my_output_hhalign_iterations_cmd.pl r1.upgma.nwk $(SRC)
	cd $(RESULTS) && bash hhalign_iterations_cmd r1.hhalign_iterations.fasta
	cd $(RESULTS) && sleep 10 && find . -type f -name "n*" -exec rm {} + && find . -type f -name "u*.hhr" -exec rm {} + && find . -type f -name "u*.fas" -exec rm {} + && rm hhalign_iterations_cmd

$(RESULTS)/r1.upgma.nwk : $(RESULTS)/r1.all.hhr.list
	cd $(RESULTS) && n=$$(ls u*.fas | wc -l) && perl $(SRC)/my_hhrscore_to_distance.pl $$n r1.all.hhr.list
	cd $(RESULTS) && perl $(SRC)/my_distance_to_phylip_input.pl hhalign_distances.matrix
	cd $(RESULTS) && phylip neighbor <$(SRC)/my_neighbor_parameter
	cd $(RESULTS) && perl $(SRC)/my_tree_to_oneline.pl
	cd $(RESULTS) && cat upgma.nwk.temp0 | perl -p -i -e 's/:(\d+\.\d+)(\,)/\,/g' >upgma.nwk.temp1
	cd $(RESULTS) && cat upgma.nwk.temp1 | perl -p -i -e 's/:(\d+\.\d+)(\))/\)/g' >upgma.nwk.temp2
	cd $(RESULTS) && cat upgma.nwk.temp2 | perl -p -i -e 's/:(\-\d+\.\d+)(\,)/\,/g' >upgma.nwk.temp3
	cd $(RESULTS) && cat upgma.nwk.temp3 | perl -p -i -e 's/:(\-\d+\.\d+)(\))/\)/g' >upgma.nwk.temp4
	cd $(RESULTS) && sleep 10 && mv upgma.nwk.temp4 r1.upgma.nwk && rm hhalign_scores.matrix hhalign_distances.matrix hhalign_distances.matrix.phylip_input upgma.nwk.temp* outfile outtree

$(RESULTS)/r1.all.hhr.list : $(RESULTS)/r1.log.usearch_muscle.log
	cd $(RESULTS) && n=$$(ls u*.fas | wc -l) && perl $(SRC)/my_output_hhalign_allpairs_cmd.pl $$n $(HHALIGN_M) hhalign_allpairs_cmd
	cd $(RESULTS) && l=$$(wc -l hhalign_allpairs_cmd | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n hhalign_allpairs_cmd split && ls split* >list
	cd $(RESULTS) && parallel -j$(CPU) bash {} ">" {}.hhr :::: list
	cd $(RESULTS) && sleep 10 && cat split*.hhr >r1.all.hhr
	cd $(RESULTS) && perl $(SRC)/my_hhrscore_to_list.pl r1.all.hhr
	cd $(RESULTS) && n=$$(ls u*.fas | wc -l) && perl $(SRC)/my_check_undo_hhr.pl $$n $(HHALIGN_M) r1.all.hhr.list
	cd $(RESULTS) && bash hhalign_allpairs_cmd >r1.new.hhr
	cd $(RESULTS) && cat r1.all.hhr r1.new.hhr >r1.all.new.hhr
	cd $(RESULTS) && perl $(SRC)/my_hhrscore_to_list.pl r1.all.new.hhr
	cd $(RESULTS) && mv r1.all.new.hhr.list r1.all.hhr.list
	cd $(RESULTS) && sleep 10 && rm split* list hhalign_allpairs_cmd r1.all.hhr r1.new.hhr r1.all.new.hhr

$(RESULTS)/r1.log.usearch_muscle.log : $(RESULTS)/refseq_RDRP_domain.fasta.filtered.fasta
	cd $(RESULTS) && usearch -cluster_fast refseq_RDRP_domain.fasta.filtered.fasta -id $(USEARCH_ID) -msaout u
	cd $(RESULTS) && for i in u*;do mv $$i $${i}.fa;done
	-cd $(RESULTS) && for i in u*.fa;do muscle -align $${i} -output $${i}s --threads $(CPU);done
	cd $(RESULTS) && sleep 10 && find . -type f -name "u*.fas" -exec ls {} + >r1.log.usearch_muscle.log && find . -type f -name "u*.fa" -exec rm {} +

# RefseqRDRPDomainStrictFilter

$(RESULTS)/refseq_RDRP_domain.fasta.filtered.fasta : $(RESULTS)/refseq_RDRP_domain.fasta
	cd $(RESULTS) && perl $(SRC)/my_RDRP_domain_filtered.pl ref_log.jaligner.log refseq_RDRP_domain.fasta $(1MU2_JALIGNER_SCORE_CUTOFF) $(OTHERPDB_JALIGNER_SCORE_CUTOFF) $(CUTDOMAIN_LENGTH_CUTOFF)

# RefseqCutRDRPDomain

$(RESULTS)/refseq_RDRP_domain.fasta : $(RESULTS)/refseq_hmmsearch_tblout.prot.fasta
	cd $(RESULTS) && perl ${SRC}/my_fas_split_each_fa.pl refseq_hmmsearch_tblout.prot.fasta
	cd $(RESULTS) && l=$$(wc -l log.fas_split_each_fa.log | cut -f1 -d' ') && m=$$((l / $(CPU))) && n=$$((m+1)) && split -l $$n log.fas_split_each_fa.log split && ls split* >list
	cd $(RESULTS) && echo "RefseqID	BestJalignerPDBID	BestJalignerScore	CutDomainLength">ref_log.jaligner.log && parallel -j$(CPU) bash $(SRC)/my_cut_RDRP_domain.sh $(SRC) {} ref_log.jaligner.log :::: list
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.cut_RDRP_domain.fas" -exec cat {} + >refseq_RDRP_domain.fasta
	cd $(RESULTS) && sleep 10 && find . -type f -name "*.cut_RDRP_domain.fas" -exec rm {} + && rm split* list log.fas_split_each_fa.log

# RefseqStarrMethod

$(RESULTS)/refseq_hmmsearch_tblout.prot.fasta : $(RESULTS)/all.hmm $(RESULTS)/refseq_viral_proteins.fasta
	cd $(RESULTS) && hmmsearch -o refseq_hmmsearch_out --tblout refseq_hmmsearch_tblout --cpu $(CPU) -E $(HMMSEARCH_E) all.hmm refseq_viral_proteins.fasta
	cd $(RESULTS) && perl $(SRC)/my_hmmsearch_tblout_id_to_fas.pl refseq_hmmsearch_tblout refseq_viral_proteins.fasta
	cd $(RESULTS) && sleep 10 && rm refseq_hmmsearch_out refseq_hmmsearch_tblout

$(RESULTS)/refseq_viral_proteins.fasta : | $(RESULTS)
	cd $(RESULTS) && curl -O ftp.ncbi.nih.gov/refseq/release/viral/viral.[1-4].protein.faa.gz
	cd $(RESULTS) && gunzip viral*.gz
	cd $(RESULTS) && sleep 10 && cat viral.*.protein.faa >refseq_viral_proteins.fasta
	cd $(RESULTS) && sleep 10 && rm viral.*.protein.faa

# DownloadHMM

$(RESULTS)/all.hmm : $(HMMFILES) $(RESULTS)/Cystoviridae_convert.hmm
	cd $(RESULTS) && sleep 10 && cat *_convert.hmm > all.hmm

$(HMMFILES) : | $(RESULTS)
	cd $(RESULTS) && curl -o $(call substr,$(@F),1,7).hmm http://pfam.xfam.org/family/$(call substr,$(@F),1,7)/hmm
	cd $(RESULTS) && hmmconvert $(call substr,$(@F),1,7).hmm > $(@F) && rm $(call substr,$(@F),1,7).hmm 

$(RESULTS)/Cystoviridae_convert.hmm : | $(RESULTS)
	cd $(RESULTS) && wget -c https://figshare.com/ndownloader/files/15584354 -O Cystoviridae.hmm
	cd $(RESULTS) && hmmconvert Cystoviridae.hmm >Cystoviridae_convert.hmm && rm Cystoviridae.hmm

.PHONY : CommandsCheck
CommandsCheck : | $(RESULTS)
	@cd $(RESULTS) && hhalign --help >temp.hhalign-allOptionCheck.temp && perl $(SRC)/my_check_hhalign_all_option.pl temp.hhalign-allOptionCheck.temp temp.hhalign-allOptionCheck.out.temp && test -s temp.hhalign-allOptionCheck.out.temp || { echo "your hhalign command version don't have the -all option! Exiting... Try to reinstall your HHsuite following https://github.com/soedinglab/hh-suite"; exit 1; } && rm temp.hhalign-allOptionCheck.temp temp.hhalign-allOptionCheck.out.temp

$(RESULTS) :
	mkdir -p $@

##############################################################################################################################
.PHONY : clean
clean :
	-cd $(RESULTS) && rm split* list* temp* n* u* outfile outtree ref_hhalign.fasta_checked.fasta.ckp ref_hhalign.fasta_checked.fasta.log ref_hhalign.fasta_checked.fasta.out own_ref_hhalign.fasta_checked.fasta.ckp own_ref_hhalign.fasta_checked.fasta.log own_ref_hhalign.fasta_checked.fasta.out && rm *.fas

.PHONY : cleanall
cleanall :
	-cd $(RESULTS) && rm ./*
