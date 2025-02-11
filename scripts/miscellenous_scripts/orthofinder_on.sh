#!/usr/bin/env bash
#PBS -l select=8:ncpus=24:mpiprocs=24:mem=120gb
#PBS -q normal
#PBS -l walltime=48:00:00
#PBS -o /home/fkebaso/lustre/projects/hippo/long_reads/run_2/hcamelina_male/results/orthofinder/galaxy_softmasked_on/orthofinder.out
#PBS -e /home/fkebaso/lustre/projects/hippo/long_reads/run_2/hcamelina_male/results/orthofinder/galaxy_softmasked_on/orthofinder.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N orthofinder_hcm-f_on

set -eu

# ----------------------Orthofinder------------------------

#  Gene clustering

# ---------------- Requirements ------------------

echo "Initilizing variables..."
basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/orthofinder/galaxy_softmasked_on"
prot_sequences="${basedir}/proteindb"
results="${basedir}/analysis_outputs_on"
threads=58

# Remove output directory if it already exists

echo Confirming inputs:

grep -c ">" ${prot_sequences}/*.faa

echo Creating required directories...

mkdir -p "${basedir}"

touch "${basedir}/orthofinder.err" "${basedir}/orthofinder.out"

# ---------------- Modules -----------------------

echo "Loading required modules/Activating required environment..."

source /nfs/fkebaso/softwares/mambaforge/bin/activate /nfs/fkebaso/softwares/mambaforge/envs/orthofinder

echo "Conda environment activated!"


echo Finding orthologs... 

#OrthoFinder script for fast, accurate and comprehensive for performing comparative genomics

orthofinder -M msa -f "${prot_sequences}" -t $threads -y -a $threads -S blast -o "${results}"

echo OrthoFinder Completed successfully !!! 


# OrthoFinder is a fast, accurate and comprehensive platform for comparative genomics. 
#It finds orthogroups and orthologs, infers rooted gene trees for all orthogroups and identifies all 
#of the gene duplication events in those gene trees. It also infers a rooted species tree for the species
# being analysed and maps the gene duplication events from the gene trees to branches in the species tree.
# OrthoFinder also provides comprehensive statistics for comparative genomic analyses. 