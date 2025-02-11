set -eu

# Improving draft assemblies (Single base differences, Small indels,
# Larger indel or block substitution events, Gap filling, Identification
# of local misassemblies, including optional opening of new gap)

# Set the work directory
basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male"
genome="${basedir}/results/galaxy_fcs/cleaned_genome/ncbi_submitted_genome/Hcamelina_male_final_cleaned_genome.fa"
bam_file="${basedir}/results/mapping_short/galaxy_fcs/Hcamelina_male_final_cleaned_genome_mapped.sorted.bam"
out_prefix=$(basename ${genome%.*})
results="${basedir}/results/pilon/galaxy_fcs" 
echo "Activating conda environment.."

source /nfs/fkebaso/softwares/mambaforge/bin/activate /nfs/fkebaso/softwares/mambaforge/envs/pilon

echo "Environment activated...."

echo "Creating the directory for the Pilon output files..."

mkdir -p "${results}"

echo "Running Pilon with the specified parameters..."

java -Xmx240g -jar /nfs/fkebaso/softwares/mambaforge/envs/pilon/share/pilon-1.24-0/pilon.jar \
--genome "${genome}" \
--frags "${bam_file}" \
--fix "snps","gaps","local","amb" \
--changes \
--tracks \
--diploid \
--output $(basename ${genome%.*}) \
--outdir "${results}"

echo "Pilon has finished running."
