set -eu 

# ---------------- braker Gene Prediction ----------------

# Ab inition gene prediction

# ----------------Modules------------------

#source /nfs/fkebaso/softwares/mambaforge/bin/activate nfs/fkebaso/softwares/mambaforge/envs/braker

# Create output variables
echo "Creating output variables..."
basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male"
results="${basedir}/results/braker/galaxy_masked_softmasking_off"
genome="${basedir}/results/repeatmasker/galaxy_fcs/H_camelina_male_genome.fa"
protein_file="${basedir}/data/protein_db/Dme_glossina_proteins.fa"
threads=48
mincontig=200   
email="fredrickkebaso@gmail.com"

# Set path to Genemark

export GENEMARK_PATH=/nfs/fkebaso/softwares/GeneMark-ETP/bin/gmes
export PROTHINT_PATH=/nfs/fkebaso/softwares/ProtHint/bin

echo "Creating new output directory..."

mkdir -p $results

# ---------------- Run -----------------------

# Run BRAKER using Singularity
echo "Running BRAKER..."
braker.pl \
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
#--GENEMARK_PATH=${GeneMarkPath}


echo Gene prediction done.
#--softmasking \

