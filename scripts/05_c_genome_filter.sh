#!/bin/bash
set -eu

basedir="/home/kebaso/Documents/projects/hippo/long_reads/run_2/hcamelina_male/results/galaxy_fcs"
genome="${basedir}/hcamelina_male_cleaned_assembly.fa"
results="${basedir}/cleaned_genome"
bedfiles=("${basedir}/contaminated_bed_file_split_1.bed"
            "${basedir}/contaminated_bed_file_split_2.bed" ) 
contaminated_contigs="${basedir}/contaminated_contigs.txt"


echo "Creating results directories..."

mkdir -p "${results}"

source /home/kebaso/mambaforge/bin/activate 

echo Renaming the ncbi genome...

genome_file=$(basename ${genome%.*})

seqkit replace -p "\s.+" $genome | seqkit replace -p "lcl|" -r '' | seqkit replace -p "\|" -r '' > ${results}/${genome_file}_renamed.fa

echo Obtaining contaminated contigs...

seqkit grep -f $contaminated_contigs ${results}/${genome_file}_renamed.fa > ${results}/contaminated_contigs.fa

echo Filtering non contaminated contigs from contaminated contigs...

grep ">" "${results}/${genome_file}_renamed.fa" | sed 's/>//' > "${results}/${genome_file}_contig_ids.txt"

grep -w -v -f "$contaminated_contigs" "${results}/${genome_file}_contig_ids.txt" > "${results}/${genome_file}_non_contaminated_contig_ids.txt" 

#cat ${results}/${genome_file}_non_contaminated_contig_ids.txt | wc -l

seqkit grep -f  ${results}/${genome_file}_non_contaminated_contig_ids.txt ${results}/${genome_file}_renamed.fa > ${results}/${genome_file}_non_contaminated_contigs.fa

grep -c ">" ${results}/${genome_file}_non_contaminated_contigs.fa

echo Extracting sequences using the bed files...

count=0
for file in "${bedfiles[@]}"; do
    count=$((count + 1))
    seqkit subseq --bed "$file" \
    "${results}/contaminated_contigs.fa" \
    --out-file "${results}/de_contam_genome_split_${count}.fa"
done

echo Concatenating split genomes...

> ${results}/final_decontaminated_genome.fa

cat ${results}/de_contam_genome_split_*.fa >> ${results}/final_decontaminated_genome.fa

cat ${results}/final_decontaminated_genome.fa ${results}/${genome_file}_non_contaminated_contigs.fa >> ${results}/${genome_file}_final_cleaned_gemome.fa

echo "Removing contigs < 200 and any gaps...."

seqkit seq --remove-gaps  --min-len 200 ${results}/${genome_file}_final_cleaned_gemome.fa > ${results}/${genome_file}_filtered_assembly.fa

echo Done.

grep -c ">" ${results}/*.fa
   