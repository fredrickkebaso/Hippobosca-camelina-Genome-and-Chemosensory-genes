set -eu

basedir_m="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/orthofinder/galaxy_softmasked_off/validated_genes_analysis"
basedir_f="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_female/results/orthofinder/galaxy_softmasked_off/validated_genes_analysis"

results="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/gene_names"

mkdir -p ${results}/final_gene_seqs

echo Counting number of genes...


cp ${results}/*s_seq.fasta ${results}/final_gene_seqs

rm ${results}/final_gene_seqs/predicteds_seq.fasta

rm ${results}/final_gene_seqs/SNMP_copys_seq.fasta

grep -c "^>" ${results}/final_gene_seqs/*.fasta

echo "Done"