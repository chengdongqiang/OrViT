for i in own_contigs.fasta Cystoviridae_convert.hmm all.hmm refseq_viral_proteins.fasta refseq_hmmsearch_tblout.prot.fasta refseq_RDRP_domain.fasta refseq_RDRP_domain.fasta.filtered.fasta r1.log.usearch_muscle.log r1.all.hhr.list r1.upgma.nwk r1.hhalign_iterations.fasta r1.hhalign_iterations.fasta_checked.fasta r1.eachfatotemplate.hhr.list refseq_RDRP_domain.fasta.motifchecked.fasta r2.log.usearch_muscle.log r2.all.hhr.list r2.upgma.nwk r2.hhalign_iterations.fasta r2.hhalign_iterations.fasta_checked.fasta r2.eachfatotemplate.hhr.list ref_hhalign.fasta ref_hhalign.fasta_checked.fasta ref_RAxML_bipartitions.bootstrap protid_taxid_rank.list RiViT.refseq.nwk own_proteins.fasta own_hmmsearch_tblout.prot.fasta own_RDRP_domain.fasta own.eachfatotemplate.hhr.list own_RDRP_domain.fasta.motifchecked.fasta own_ref_hhalign.fasta own_ref_hhalign.fasta_checked.fasta own_ref_RAxML_bipartitions.bootstrap RiViT.ownseq_refseq.nwk
do
	if [ -f "$i" ]; then
		echo "$i exists."
		sleep 2
		touch $i
	fi
done
