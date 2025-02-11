#!/bin/bash

# Source and destination directories
source_user="fkebaso"
source_host="lengau.chpc.ac.za"
source_dir="/home/fkebaso/lustre/projects/hippo/long_reads/hcamelina_male/results/braker/ncbi_fcs_final/genome.fa"
destination_dir="/home/kebaso/Documents/projects/hippo/long_reads/hcamelina_male/results/orthofinder/ncbi_fcs_final/post_orthofiles/hcamelina_male_genome.fa" 

echo "Copying files rsync"

rsync -av -e ssh "${source_user}@${source_host}:${source_dir}" "$destination_dir"

echo "Copying done"
