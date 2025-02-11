#!/bin/bash
#PBS -l select=1:ncpus=48:mpiprocs=48:mem=300gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/braker/galaxy_masked_softmasking_off/braker.out
#PBS -e /mnt/lustre/users/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/braker/galaxy_masked_softmasking_off/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_hcm_masked_softmasking_off

set -eu 

# ---------------- braker Gene Prediction ----------------

# Ab inition gene prediction

# ----------------Modules------------------

# Load Singularity module

module load chpc/BIOMODULES
module add singularity/2.5.0
module add BRAKER/3-singularity

# Create output variables
echo "Creating output variables..."
basedir="/home/fkebaso/lustre/projects/hippo/long_reads/run_2/hcamelina_male"
results="${basedir}/results/braker/galaxy_masked_softmasking_off"
genome="${basedir}/results/repeatmasker/galaxy_fcs/H_camelina_male_genome.fa"
protein_file="${basedir}/data/protein_db/Dme_glossina_proteins.fa"
threads=48
mincontig=200   
email="fredrickkebaso@gmail.com"

# Set path to BRAKER Singularity container
export BRAKER_SIF="/apps/chpc/bio/BRAKER-3.0.3/braker3.sif"

echo "Creating new output directory..."

mkdir -p $results

# Create empty output files for braker.out and braker.err
echo "Creating empty output files..."

touch "${results}/braker.err" "${results}/braker.out"

# ---------------- Run -----------------------

# Run BRAKER using Singularity
echo "Running BRAKER..."
singularity exec -B ${PWD}:${PWD} ${BRAKER_SIF} braker.pl \
--genome="${genome}" \
--prot_seq="${protein_file}" \
--threads "${threads}" \
--workingdir="${results}" \
--min_contig="${mincontig}" \
--softmasking_off \
--augustus_args="--species=fly" \
--gff3 \
--makehub \
--email "${email}" 

echo Gene prediction done.
#........................RE-RUNNING BRAKER2...................
# Set the working directory for the new run
new_work_dir="${basedir}/results/braker/galaxy_masked_softmasking_off_restart"

# Set the directory for the previous run
oldDir="${basedir}/results/braker/galaxy_masked_softmasking_off"

# Check if the working directory exists
if [ ! -d $new_work_dir ]; then
    echo "Working directory $new_work_dir does not exist. Creating directory..."
    mkdir -p $new_work_dir
fi

# Check if the directory of the previous run exists
if [ ! -d $oldDir ] ; then
  echo "ERROR: Directory (with contents) of old BRAKER run $oldDir does not exist, yet." 
else
    species=$(cat $oldDir/braker.log | perl -ne 'if(m/AUGUSTUS parameter set with name ([^.]+)\./){print $1;}')
    echo "Running BRAKER with restart..."
    # Run BRAKER with restart and measure the execution time
    singularity exec -B ${PWD}:${PWD} ${BRAKER_SIF} braker.pl \
     --genome="${oldDir}"/genome.fa \
    --hints="${oldDir}"/hintsfile.gff \
    --skipAllTraining  \
    --species="${species}" \
    --workingdir="${new_work_dir}" \
    --threads "${threads}" > "${new_work_dir}"/braker_restart.log
fi

echo "Braker run completed successfully!"

