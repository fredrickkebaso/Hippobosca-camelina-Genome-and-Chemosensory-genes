set -eu

echo Running Busco....

basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_female"
results="${basedir}/results/compleasam/gene_quality/ncbi_fcs_final"
predicted_genes=("${basedir}/results//braker/ncb_fcs_final_restart/hcamelina_female.faa")
databases="/nfs/fkebaso/projects/hippo/long_reads/data/databases/busco_db"
hmm_search_path="/home/fkebaso/.conda/envs/compleasam/bin/hmmsearch"
threads=32
lineages=("metazoa_odb10" "arthropoda_odb10" "insecta_odb10" "diptera_odb10")
          
echo "Loading required modules/Activating required environment..."

source /opt/conda/bin/activate /home/fkebaso/.conda/envs/compleasam

echo "Conda environment activated!"

if [ ! -d "$databases" ]; then
  # Create directory if it doesn't exist
  
  mkdir -p "$databases"
  
  echo "Downloading ${lineages[@]} datasets"
  
   compleasm download lineages ${lineages[@]} ${threads} --library_path ${databases}
  
  echo "Downloading databases done."
fi

echo "Running Compleasm gene evaluation..."

for genome in "${predicted_genes[@]}"; do
    out_dir=$(basename "${genome}" .fa)
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
        compleasm protein \
          --proteins "${predicted_genes}" \
          --outdir ${results}/${out_dir}/${lineage} \
          --threads "${threads}" \
          --lineage "${lineage}" \
          --library_path ${databases} \
          --hmmsearch_execute_path "${hmm_search_path}"
    done
    
    echo Collecting reports to one file...

    cat ${results}/${out_dir}/*/*/short_*.txt >> ${results}/${out_dir}/busco_summary_reports.txt

    echo Report collection completed...
done
