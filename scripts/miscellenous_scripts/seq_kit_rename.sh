#!/bin/bash

#Renames the predicted gene ids by adding a prefix that corresponds to the species and assembly tool

set -eu

#Setting variables
basedir="/home/fkebaso/lustre/hippo/long_reads/hcamelina_female/results"
predicted_genes=${basedir}/braker/fcs_cleaned_restart
orthofinder_dir="${basedir}/orthofinder/proteindb"
prefix="hcf_"
species="hcamelina_female"

#Create outputdir

mkdir -p ${orthofinder_dir}

#Rename the predicted genes to match the organism name
source /home/fkebaso/lustre/software/bin/activate /home/fkebaso/lustre/software/envs/seqkit

echo Renaming predicted genes...

seqkit replace -p ^ -r ${prefix} ${predicted_genes}/braker.codingseq > ${predicted_genes}/${species}.codingseq

echo Copying renamed files files...

cp ${predicted_genes}/${species}.codingseq ${predicted_genes}/braker_renamed.codingseq

echo Done 

#echo Renamed genes in ${orthofinder_dir}
echo Done.

# replace: This option specifies that the operation to be performed is a replacement of text.
# -p: This option specifies the regular expression pattern to match. In this case, ^ is used as the pattern, which matches the beginning of each line.
# -r: This option specifies the replacement text. In the command, "hcv_" is provided as the replacement, which will be added at the beginning of each matched line.
# hcamelina_velvet.faa: This is the input file name. It refers to the multifasta file from which you want to modify the sequence headers.