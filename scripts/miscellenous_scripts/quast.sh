set -eu

#Genome assessment using quast

echo "Creating output directories..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_female"
genomes=("${basedir}/results/repeatmasker/hcamelina_female_genome.fa")
threads=52
nanopore="${basedir}/results/cleaned_reads/hcamelina_female_chopped_200_total.fastq.gz"
forward_read="/home/fkebaso/nfs/projects/hippo/short_reads/backups/hcamelina_male/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/kraken/hcamelina_male_unclassified_reads_1.fq.gz" # Path to the forward read file
reverse_read="/home/fkebaso/nfs/projects/hippo/short_reads/backups/hcamelina_male/mnt/lustre/users/fkebaso/hippo/hcamelina_male/results/kraken/hcamelina_male_unclassified_reads_2.fq.gz"  # Path to the reverse read file
results="${basedir}/results/quast/merged_assembly"

echo "Remove output directory if it already exists"

mkdir -p "${results}"

echo "Loading required modules/Activating required environment..."

echo Conda activating environment...

source /opt/conda/bin/activate /home/fkebaso/.conda/envs/quast

echo Environment activated !!!

echo "Running quast..."

quast-lg.py "${genomes[@]}" \
--output-dir "${results}" \
--min-contig 0 \
--threads "${threads}" \
--k-mer-stats \
--circos \
--gene-finding \
--conserved-genes-finding \
--use-all-alignments \
--report-all-metrics \
--eukaryote \
--nanopore "${nanopore}" 

echo "Quast assessment completed successfully !!!"

#\
#--pe1 "${forward_read}" \
#--pe2 "${reverse_read}" 