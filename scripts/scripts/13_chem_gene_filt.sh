set -eu

basedir="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/gene_names"
results="${basedir}/merged_chem_genes"
merged_genes="${basedir}/merged_chem_gene_ids"

source /home/kebaso/miniforge3/bin/activate /home/kebaso/miniforge3/envs/seqkit

mkdir -p ${results}

for file in ${basedir}/*s_seq.fasta; #*s_seq.fasta;

do

basename=$(basename $file ".fasta")

echo $basename

#echo ${merged_genes}/${basename}.txt

grep "^>" $file| grep "Hcam" | sed 's/^>//' > ${results}/${basename}_temp.txt

seqkit grep -v -f ${results}/${basename}_temp.txt $file > ${results}/${basename}.fasta

seqkit grep -f ${merged_genes}/${basename}.txt $file >> ${results}/${basename}.fasta

grep -c "^>Hcam" ${results}/${basename}.fasta

grep -c "^>" ${results}/${basename}.fasta

done

rm ${results}/*_temp.txt
