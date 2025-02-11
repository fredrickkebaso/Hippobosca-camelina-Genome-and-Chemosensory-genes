set -eu

basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_female"
reads="${basedir}/results/cleaned_reads/hcamelina_female_chopped_200_total.fastq.gz"
results="${basedir}/results/wtdbg2_200"
threads=32

mkdir -p ${results}

touch ${results}/wtdbg2.err ${results}/wtdbg2.out

echo Activating required environment

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/wtdbg2

echo Environment activated !!!

echo Running wtdbg2....

wtdbg2 -x nanopore -g 160m -t ${threads} --input $reads -fo ${results}/wtdbg2
    
wtpoa-cns -i ${results}/wtdbg2.ctg.lay.gz -fo ${results}/wtdbg2.ctg.fa 

echo Read processing done !!!


#Install using Mamba

#!/bin/bash

# Directory containing the exported YAML files
export_dir="conda_env_exports"

# Check if the export directory exists
if [ ! -d "$export_dir" ]; then
    echo "Export directory $export_dir does not exist."
    exit 1
fi

# Loop through each YAML file in the export directory
for file in $export_dir/*.yml; do
    # Extract the environment name from the file name
    env_name=$(basename "$file" .yml)

    # Remove the environment if it already exists
    if conda env list | grep -q "^$env_name "; then
        echo "Environment $env_name exists. Removing it."
        mamba env remove --name "$env_name"
    fi

    # Create the environment from the YAML file
    echo "Creating environment $env_name from $file"
    mamba env create --file "$file"

    # Check if the environment creation was successful
    if [ $? -ne 0 ]; then
        echo "Failed to create environment $env_name from $file"
        exit 1
    fi
done

echo "All environments have been successfully recreated from the YAML files."
