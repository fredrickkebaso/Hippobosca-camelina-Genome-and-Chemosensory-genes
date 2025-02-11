#!/bin/bash

#Renames the predicted gene ids by adding a prefix that corresponds to the species and assembly tool

set -eu

#Setting variables
basedir="/home/kebaso/Documents/projects/hippo/long_reads/hcamelina_male/results/fcs/ncbi_fcs/ncbi_fcs_2/cleaned_genome/submitted_genome"
genome="${basedir}/Hippobosca_camelina_male_genome.fa"

#Rename the genome
source /home/kebaso/mambaforge/bin/activate 

echo Renaming contigs and removing any gaps...

renamed_genome=$(basename $genome .fa)

seqkit replace -p .+ -r "contig_{nr}" ${genome} | seqkit replace -p " |-" -s > ${basedir}/${renamed_genome}_renamed.fa

echo Done renaming and removing gaps...

