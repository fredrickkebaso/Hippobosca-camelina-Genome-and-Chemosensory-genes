set -eu

basedir="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/gene_names"
results="${basedir}/camelina_chem_genes"

source /home/kebaso/miniforge3/bin/activate /home/kebaso/miniforge3/envs/seqkit

mkdir -p ${results}

for file in ${results}/*_seq.fasta;

do

seqkit fx2tab -n -l $file 

done