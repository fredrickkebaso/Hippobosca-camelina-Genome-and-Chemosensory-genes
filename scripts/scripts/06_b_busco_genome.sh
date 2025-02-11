set -eu

echo Running Busco....

basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results"

#Initalizing variables
results="${basedir}/busco/genome_quality/galaxy_fcs_masked"
genomes=("${basedir}/repeatmasker/galaxy_fcs/H_camelina_male_genome.fa")
mode="genome"
databases="/nfs/fkebaso/projects/hippo/long_reads/data/busco_databases/busco_db"
threads=42
lineages=("metazoa_odb10" "arthropoda_odb10" "insecta_odb10" "diptera_odb10")
          
echo "Loading required modules/Activating required environment..."

source /nfs/fkebaso/softwares/mambaforge/bin/activate /nfs/fkebaso/softwares/mambaforge/envs/busco


echo "Conda environment activated!"

if [ ! -d "$databases" ]; then
  # Create directory if it doesn't exist
  
  mkdir -p "$databases"
  
  echo "Downloading ${lineages[@]} datasets"
  
  cd ${databases}
  
  busco  --cpu ${threads} --force --download ${lineages[@]} 
  
  cd $basedir
  
  echo "Downloading databases done."
fi

echo "Running Busco genome evaluation..."

# Download lineages
# Download lineages
for genome in "${genomes[@]}"; do
    out_dir=$(basename "${genome%.*}")
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
        busco --offline \
            --in "${genome}" \
            --force \
            --lineage "${lineage}" \
            --augustus \
            --augustus_species "fly" \
            --out "${lineage}_stats" \
            --mode ${mode} \
            --cpu "${threads}" \
            --datasets_version odb10 \
            --download_path "${databases}/busco_downloads" \
            --out_path ${results}/${out_dir}/${lineage} 
    done
    
    echo Collecting reports to one file...

    cat ${results}/${out_dir}/*/*/short_*.txt >> ${results}/${out_dir}/busco_summary_reports.txt

    echo Report collection completed...
done
