#!/bin/bash

#Renames the predicted gene ids by adding a prefix that corresponds to the species and assembly tool

set -eu

#Setting variables
basedir="/home/kebaso/Documents/projects/hippo/long_reads/hcamelina_male/results/fcs/ncbi_fcs/ncbi_fcs_3"
genome="${basedir}/Hippobosca_camelina_male_genome_renamed.fa"
threads=4

#Rename the predicted genes to match the organism name
source /home/kebaso/mambaforge/bin/activate 

echo Scanning for duplicated seqs...

renamed_genome=$(basename $genome .fa)

seqkit rmdup --by-seq \
--threads $threads \
--dup-num-file ${renamed_genome}_duplicated_seq.txt \
--dup-seqs-file  ${renamed_genome}_duplicated_seqs.fa \
--out-file ${renamed_genome}_deduplicated.fa \
${genome} 

echo Done scanning...

