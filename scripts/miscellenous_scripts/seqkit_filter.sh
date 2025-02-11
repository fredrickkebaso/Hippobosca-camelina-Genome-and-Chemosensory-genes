#!/bin/bash

source /home/fkebaso/mambaforge/bin/activate

echo Filtering contigs below 200 basepairs

# Define base directory
basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results"
results="${basedir}//flye"

#Define input files  hvariegata_f_spades_genome.fa
genome_file="${results}/assembly.fasta"
threads=24
new_file=$(basename ${genome_file%.*})

echo Number of original contigs $(grep -c "^>" ${genome_file})

seqkit seq --remove-gaps  --min-len 200 "${genome_file}" > ${results}/${new_file}_filtered_assembly.fa

echo Calculating filtered assembly stats..

seqkit stats --all ${results}/${new_file}_filtered_assembly.fa > ${results}/${new_file}_filtered_assembly_stats.txt

echo Number of remaining contigs $(grep -c "^>" ${results}/${new_file}_filtered_assembly.fa)

echo Original genome size $(ls -lh ${genome_file})

echo New genome size $(ls -lh ${results}/${new_file}_filtered_assembly.fa)