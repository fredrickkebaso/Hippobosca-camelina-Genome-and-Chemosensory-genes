set -eu

echo "Loading required modules/Activating required environment..."

source /opt/conda/bin/activate /home/fkebaso/.conda/envs/busco

echo "Environment activated successfully !!!"

#Initalizing variables

basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_female"
results="${basedir}/results/busco/gene_quality/ncbi_fcs_final"
predicted_genes=("${basedir}/results//braker/ncb_fcs_final_restart/hcamelina_female.faa")
databases="/home/fkebaso/nfs/projects/hippo/long_reads/data/databases/busco_db"
threads=62
lineages=("metazoa_odb10" "arthropoda_odb10" "insecta_odb10" "diptera_odb10")
          

if [ ! -d "$databases" ]; then
  # Create directory if it doesn't exist
  
  mkdir -p "$databases"
  
  echo "Downloading ${lineages[@]} datasets"
  
  cd ${databases}
  
  busco  --cpu ${threads} --force --download ${lineages[@]} 
  
  cd $basedir
  
  echo "Downloading databases done."
fi

echo "Running Busco gene evaluation..."

# Download lineages
for genome in "${predicted_genes[@]}"; do
    out_dir=$(basename "${genome}" .aa)
    mkdir -p "${results}/${out_dir}"
    for lineage in "${lineages[@]}"; do
        busco --offline \
        --in "${genome}" \
        --lineage "${lineage}" \
        --out "${lineage}_stats" \
        --force \
        --mode prot \
        --cpu ${threads} \
        --datasets_version odb10 \
        --download_path "${databases}/busco_downloads" \
        --out_path ${results}/${out_dir}/${lineage} 
    done
    
     echo Collecting reports to one file...

    cat ${results}/${out_dir}/*/*/short_*.txt >> ${results}/${out_dir}/busco_summary_reports.txt

    echo Report collection completed...
    
done

#--evalue 0.001 --species "fly" \
#--download_path "${results}/${out_dir}"
# --download_path "${results}/${out_dir}" \
#         --scaffold_composition \
#         --update-data
#--out_path "${results}/${out_dir}" 
#NAME - name to use for the run and temporary files 
#GENE_SET gene set protein sequence file in fasta format 
#LINEAGE path to the lineage to be used (-l /path/to/lineage)
# --out_path OUTPUT_PATH  Optional location for results folder, excluding results folder name. Default is current working directory.
# --force           Force rewriting of existing files. Must be used when output files with the provided name already exist.
#--download_path DOWNLOAD_PATH Specify local filepath for storing BUSCO dataset downloads
#  -c N, --cpu N         Specify the number (N=integer) of threads/cores to use.