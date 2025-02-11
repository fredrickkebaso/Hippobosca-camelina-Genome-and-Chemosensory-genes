set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/veritymapping/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

echo Mapping long reads to assembly....

veritymap -t $threads --reads $reads -d ont -o $results $genome

echo Mapping completed successfully !!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



set -eu 

#-----------------------------mapping_statistics---------------------------------

echo "Creating output variables..."

# Define base directory
basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results"
results="${basedir}/mapping_long_reads/merged_assembly"

# Define input files 
genome_files=("${basedir}/quick_merge/chopped_200_assemblies/merged_out.fasta")
num_threads=64

# Raw reads

reads="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male/results/cleaned_reads/hcamelina_male_chopped_200_total.fastq.gz"

# Create mapping_stats directory if it doesn't exist
echo "Creating mapping_stats directory..."
mkdir -p "${results}"

# Activate required environment
echo "Activating the quast environment..."

source /home/fkebaso/mambaforge/bin/activate  /home/fkebaso/mambaforge/envs/mapping

echo Environment activated successfully!!

# Index the genomes
echo "Indexing the genomes..."
for file in "${genome_files[@]}"; do
    echo "Indexing '${file}'..."
    bwa index "${file}"
done

# Map reads to indexed assembly
echo "Mapping reads to indexed assembly..."
for file in "${genome_files[@]}"; do
    echo "Mapping '${file}'..."
    file_name=$(basename "${file%.*}")
    echo "Mapping reads to ${file_name} assembly..."
    bwa mem -t "${num_threads}" "${file}" -x ont2d "${reads}" > "${results}/${file_name}_mapped.sam"

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



