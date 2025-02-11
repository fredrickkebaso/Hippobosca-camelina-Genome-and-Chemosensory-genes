#!/usr/bin/env bash
#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -q normal
#PBS -l walltime=24:00:00
#PBS -o /mnt/lustre/users/fkebaso/projects/hippo/long_reads/run_2/hcamelina_female/results/braker/galaxy_masked_softmasking_on_restart/braker.out
#PBS -e /mnt/lustre/users/fkebaso/projects/hippo/long_reads/run_2/hcamelina_female/results/braker/galaxy_masked_softmasking_on_restart/braker.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N braker_unmasked_restart

set -eu 

# ---------------- braker restart after augustus has finished training  ----------------

# Option 3: starting BRAKER after AUGUSTUS training

# ----------------Modules------------------

# Load Singularity module

module load chpc/BIOMODULES
module add singularity/2.5.0
module add BRAKER/3-singularity

# Create output variables

# Set path to BRAKER Singularity container
export BRAKER_SIF="/apps/chpc/bio/BRAKER-3.0.3/braker3.sif"

# Set the base directory
basedir="/mnt/lustre/users/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male"
threads=48
# Set the working directory for the new run
new_work_dir="${basedir}/results/braker/galaxy_masked_softmasking_on_restart"

# Set the directory for the previous run
oldDir="${basedir}/results/braker/galaxy_masked_softmasking_on"

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