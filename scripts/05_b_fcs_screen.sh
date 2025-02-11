set -eu

# ---------------- Contamination checks ----------------

# Activating required environment...
#source /opt/conda/bin/activate /home/fkebaso/.conda/envs/fcs

# Create output variables
echo "Creating output variables..."
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male"
results="${basedir}/results/fcs_contaminations" 
genome="${basedir}/results/repeatmasker/H_camelina_male_genome.fa"
gx_db="/home/fkebaso/nfs/projects/hippo/long_reads/data/databases"
env_file="${basedir}/scripts/env.txt"
threads=48
mincontig=100   
email="fredrickkebaso@gmail.com"

export FCS_DEFAULT_IMAGE="/home/fkebaso/nfs/projects/hippo/long_reads/git_tools/fcs-gx.sif"

# Add the directory containing fcs.py to PATH
export PATH=$PATH:/home/fkebaso/nfs/projects/hippo/long_reads/git_tools

echo "Creating new output directory..."

mkdir -p $results

echo "Screening the genome..."

singularity exec -B ${PWD}:${PWD} ${FCS_DEFAULT_IMAGE} ./fcs.py screen genome \
--fasta $genome \
--out-dir ${results} \
--env-file ${env_file} \
--gx-db ${gx_db}/gxdb \
--tax-id 633885 \
--generate-logfile

