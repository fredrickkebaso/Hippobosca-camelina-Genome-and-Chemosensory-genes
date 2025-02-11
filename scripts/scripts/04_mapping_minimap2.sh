set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results"
results="${basedir}/mapping_long_reads/minimap2/galaxy_fcs"

# Define input files 
genome_files=("${basedir}/galaxy_fcs/cleaned_genome/ncbi_submitted_genome/Hcamelina_male_final_cleaned_genome.fa")
num_threads=32
index="${results}/index/genome.mmi"

# Raw reads

reads="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/cleaned_reads/hcamelina_male_cleaned.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the mapping environment..."

source /opt/conda/bin/activate  /home/fkebaso/.conda/envs/minimap2

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
   echo "Indexing '${file}'..."
   minimap2 -d $index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    
    minimap2 -ax map-ont -t "${num_threads}" $file $reads  > "${results}/${file_name}_mapped.sam"


    echo Converting to bam, sorting and extracting mapping statistis....

    samtools view -@ "${num_threads}" -bS "${results}/${file_name}_mapped.sam" | samtools sort -o "${results}/${file_name}_mapped.sorted.bam" -
    samtools flagstat "${results}/${file_name}_mapped.sorted.bam" > "${results}/${file_name}_mapping_stats.txt"
    samtools coverage "${results}/${file_name}_mapped.sorted.bam" > "${results}/${file_name}_coverage_stats.txt"
    samtools depth "${results}/${file_name}_mapped.sorted.bam" > "${results}/${file_name}_depth_stats.txt"

done

# Index the sorted BAM files
echo "Indexing sorted BAM files..."
for sorted_bam_file in "${results}"/*.sorted.bam; do
    echo "Indexing '${sorted_bam_file}'..."
    samtools index "${sorted_bam_file}"
done

# Echo completion message

echo "Mapping, indexing and sorting completed successfully!"



