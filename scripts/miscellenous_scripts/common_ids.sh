fasta_files="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/gene_names/merged_chem_genes"
text_files="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/gene_names/merged_chem_gene_ids"

for file in ${fasta_files}/*.fasta;
do

basename=$(basename $file .fasta)

grep "^>" $file|sed 's/^>//' | sort > ${fasta_files}/${basename}_temps.txt

sort ${text_files}/${basename}*.txt > ${text_files}/${basename}_sorted.txt

comm -3 ${fasta_files}/${basename}_temps.txt ${text_files}/${basename}_sorted.txt

done

rm ${fasta_files}/*_temps.txt

rm ${text_files}/*_sorted.txt
