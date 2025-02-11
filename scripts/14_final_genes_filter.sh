set -eu

basedir="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/merged_chem_genes"
results="${basedir}/Final_genes/Final_gene_sequences"
gene_ids="${basedir}/Final_genes/Final_gene_ids"
sequences="${basedir}/v_1"
chem_ids=(CSPs_ids.txt  GRs_ids.txt  IRs_ids.txt  OBPs_ids.txt  ORs_ids.txt  SNMPs_ids.txt)

source /home/kebaso/miniforge3/bin/activate /home/kebaso/miniforge3/envs/seqkit

mkdir -p ${results}

for file in ${chem_ids[@]}
do
basename=$(basename $file _ids.txt)

seqkit grep -f  ${gene_ids}/$file ${sequences}/${basename}/deduplicated_${basename}.fasta -o ${results}/Hcam_${basename}.fasta

done

grep -c "Hcam" ${results}/*.fasta



