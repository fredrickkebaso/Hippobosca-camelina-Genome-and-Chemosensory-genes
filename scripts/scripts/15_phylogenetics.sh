#PBS -l select=1:ncpus=56:mpiprocs=56:mem=900gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /home/fkebaso/lustre/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetics/phylogenetic.out
#PBS -e /home/fkebaso/lustre/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetics/phylogenetic.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N phylogenetics

set -eu 

# For alignment of amino acids

basedir="/home/fkebaso/lustre/projects/hippo/long_reads/run_2/hcamelina_male/results"
sequences="${basedir}/orthofinder/galaxy_softmasked_off/validated_genes_analysis/merged_chem_genes"
concatenated_seqs=(SNMPs_seq.fasta CSPs_seq.fasta OBPs_seq.fasta)
concatenated_seqs_1=(ORs_seq.fasta)
concatenated_seqs_2=(GRs_seq.fasta)
concatenated_seqs_3=(IRs_seq.fasta)
results="${basedir}/phylogenetics/merged_chem_genes"
threads=56

echo "Activating relevant environment..."

source /home/fkebaso/lustre/software/bin/activate /home/fkebaso/lustre/software/envs/phylogenetics

echo "Mamba environment activated!"

# Create output directory

mkdir -p "${results}"

touch ${results}/phylogenetic.out ${results}/phylogenetic.err

for file in ${sequences}/${concatenated_seqs_3[@]};
do

    file_name=$(basename $file _seq.fasta)

    mkdir -p ${results}/${file_name}
    
    echo "Total sequences: $(grep -c ">"  ${sequences}/${file_name}_seq.fasta)"

    echo Replacing "*" with

    sed 's/\*//g' ${sequences}/${file_name}_seq.fasta > ${results}/${file_name}/edited_${file_name}.fasta

    echo Done

    echo Removing duplicated sequences by file name....

    seqkit  rmdup --by-name ${results}/${file_name}/edited_${file_name}.fasta --out-file ${results}/${file_name}/deduplicated_${file_name}.fasta --dup-seqs-file ${results}/${file_name}/duplicated_${file_name}.fasta --threads ${threads}

    echo "Aligning amino acids using muscle..."

    aln_file_name=${file_name}_aln.fa

    echo $aln_file_name

    muscle -align ${results}/${file_name}/deduplicated_${file_name}.fasta -output "${results}/${file_name}/${aln_file_name}" -consiters 50 -threads "${threads}"

    echo "Alignment completed successfully."

    echo Trimming alignment....

    modes=(automated1) #(noallgaps strictplus automated1)

    for mode in ${modes[@]}; 

    do

        mkdir -p ${results}/${file_name}/${mode}
    
        trimal -in "${results}/${file_name}/${aln_file_name}" \
        -out ${results}/${file_name}/${mode}/trimal_edited_${aln_file_name} \
        -htmlout ${results}/${file_name}/${mode}/trimal_stats_${aln_file_name}.html \
        -"${mode}"

        echo Trimming done.

        echo Running tree construction using raxml..

        echo starting RaxML tree search....

        raxml-ng --all \
        --msa ${results}/${file_name}/${mode}/trimal_edited_${aln_file_name} \
        --model LG+FC+G8m \
        --tree pars{10} \
        --bs-trees 1000 \
        --threads ${threads} \
        --workers auto{10} \
        --redo
        echo Done
    done
done
