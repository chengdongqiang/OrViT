input=$1
while read p
do
	grep -F "${p}." prot.accession2taxid.FULL >>protid_to_taxid.list
done <${input}

