set -eu

#Constructs de novo repeat library and uses it to mask the genome

#-----------------------------Load modules---------------------------------

echo "Setting up the environment..."

echo Loading required modules Or activating the required conda environment...

source /nfs/fkebaso/softwares/mambaforge/bin/activate /nfs/fkebaso/softwares/mambaforge/envs/reapeatmodeler_repeatmasker

echo Environment activated successfully!!!

# Set the work directory
basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results"
genome="${basedir}/pilon/galaxy_fcs/Hcamelina_male_final_cleaned_genome.fa.fasta"
repeatmodeler_results="${basedir}/repeatmodeler/galaxy_fcs"
repeatmasker_results="${basedir}/repeatmasker/galaxy_fcs"
threads=52
species="H_camelina_male"
db_name=$(basename "${genome%.*}")

# Create the output directory
mkdir -p "${repeatmodeler_results}"
mkdir -p "${repeatmasker_results}"


# Print progress
echo "Building the RepeatModeler database..."

# Build the RepeatModeler database

BuildDatabase -name "${repeatmodeler_results}/${db_name}_db" -engine rmblast "$genome"

# Print progress

echo "Running RepeatModeler..."

# Run RepeatModeler to identify repeat elements and build the library

RepeatModeler -database "${repeatmodeler_results}/${db_name}_db" -threads "$threads" -LTRStruct

# Print completion message

echo "Building de novo repeat library completed successfully!"

echo "Masking repeats in the genome using repeatmasker"

RepeatMasker -pa "${threads}" \
-lib "${repeatmodeler_results}/${db_name}_db-families.fa" \
-noisy -dir "${repeatmasker_results}" \
-a -xsmall -poly -source -gff "${genome}"

echo "Renaming the masked genome"

cp ${repeatmasker_results}/*.masked ${repeatmasker_results}/${species}_genome.fa


#-cutoff 250 \
echo "Repeat masking completed successfully!"




