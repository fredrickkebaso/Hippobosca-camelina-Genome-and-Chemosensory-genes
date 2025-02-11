#!/bin/bash

#Renames the predicted gene ids by adding a prefix that corresponds to the species and assembly tool

set -eu

#Setting variables
basedir="/home/fkebaso/lustre/projects/hippo/long_reads/hcamelina_female/results/repeatmasker/ncbi_fcs_genome"
genome="${basedir}/H_camelina_female_genome.fa"

#Rename the predicted genes to match the organism name
source /home/fkebaso/lustre/software/bin/activate 

echo Renaming contigs and removing any gaps...

renamed_genome=$(basename $genome .fa)

seqkit replace -p .+ -r "contig_{nr}" ${genome} | seqkit replace -p " |-" -s > ${basedir}/${renamed_genome}_renamed.fa

echo Done renaming and removing gaps...

