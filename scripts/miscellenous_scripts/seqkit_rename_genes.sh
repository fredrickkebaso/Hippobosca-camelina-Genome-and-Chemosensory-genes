#!/bin/bash

#Renames the predicted gene ids by adding a prefix that corresponds to the species and assembly tool

set -eu

#Setting variables
basedir="/home/kebaso/Documents/projects/hippo/long_reads/run_2/hcamelina_male/results"
predicted_genes="${basedir}/braker/galaxy_masked_softmasking_off"
orthofinder_dir="${basedir}/orthofinder/galaxy_softmasked_on/proteindb"
prefix="hcm_off_"
species="hcamelina_male"

#Create outputdir

mkdir -p ${orthofinder_dir}

#Rename the predicted genes to match the organism name

source /home/kebaso/mambaforge/bin/activate 

echo Renaming predicted genes...

seqkit replace -p ^ -r ${prefix} ${predicted_genes}/braker.aa > ${predicted_genes}/${species}.faa

echo Copying renamed files files...

cp ${predicted_genes}/${species}.faa ${predicted_genes}/braker_renamed.aa

cp ${predicted_genes}/${species}.faa ${orthofinder_dir}

echo Done 

echo Renamed genes in ${orthofinder_dir}
echo Done.
