set -eu

basedir="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/gene_names"

for file in "${basedir}"/*_seq.txt; do
    basename=$(basename "$file" .txt)
        
    # Using awk to add characters to the beginning of the second field and create a new column
    echo "Creating gene names for" ${basename}

    awk 'BEGIN {
        print "Gene_ID", "Gene_Name", "Sequence"
    }
    {
        if ($1 ~ /^GMOY/) {
            modified_value = "Gmm" $2  
            print $1, modified_value, $3
        }  
        if ($1 ~ /^AGAP/) {
            modified_value = "Agam" $2  
            print $1, modified_value, $3 
        } 
        if ($1 ~ /^FBgn/) {
            modified_value = "Dmel" $2  
            print $1, modified_value, $3
        }
        if ($1 ~ /^GBRI/) {
            modified_value = "Gbre" $2  
            print $1, modified_value, $3
        }
        if ($1 ~ /^GFUI/) {
            modified_value = "Gfuc" $2  
            print $1, modified_value, $3
        }
    }' "$file" > "${basedir}/${basename}_gene_names.txt"

    cut -d " " -f2,3 ${basedir}/${basename}_gene_names.txt > "${basedir}/${basename}_gene_names_2.txt"

    echo "Converting" ${basename}_gene_names_2.txt "to fasta format"

    tail -n +2 "${basedir}/${basename}_gene_names_2.txt" | while read -r line; do
    gene_name=$(echo "$line" | awk '{print $1}')
    sequence=$(echo "$line" | awk '{print $2}' | tr -d ' ')
    echo ">$gene_name"
    echo "$sequence" | fold -w 60
    done > "${basedir}/${basename}".fasta
    

    echo "Done"

done


