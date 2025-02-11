set -eu

echo Running Compleasm....

basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/results"

#Initalizing variables
results="${basedir}/compleasm/genome_quality/galaxy_fcs_masked"
genomes=("${basedir}/repeatmasker/galaxy_fcs/H_camelina_male_genome.fa")
mode="genome"
databases="/nfs/fkebaso/projects/hippo/long_reads/data/databases/busco_db"
threads=52
lineages=("metazoa_odb10" "arthropoda_odb10" "insecta_odb10" "diptera_odb10")
          
echo "Loading required modules/Activating required environment..."

source /nfs/fkebaso/softwares/mambaforge/bin/activate /nfs/fkebaso/softwares/mambaforge/envs/compleasm

echo "Conda environment activated!"

if [ ! -d "$databases" ]; then
  # Create directory if it doesn't exist
  
  mkdir -p "$databases"
  
  echo "Downloading ${lineages[@]} datasets"
  
   compleasm download lineages ${lineages[@]} ${threads} --library_path ${databases}
  
  echo "Downloading databases done."
fi

echo "Running Compleasm genome evaluation..."

# Download lineages
# Download lineages
for genome in "${genomes[@]}"; do
    out_dir=$(basename "${genome}" .fa)
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
    
        compleasm run \
          --assembly_path "${genome}" \
          --output_dir ${results}/${out_dir}/${lineage} \
          --threads "${threads}" \
          --lineage "${lineage}" \
          --library_path ${databases} 
    done
    
    echo Collecting reports to one file...

     cat ${results}/${out_dir}/*/summary.txt >> ${results}/${out_dir}/complaeasm_summary_reports.txt

    echo Report collection completed...
done
