set -eu

echo Creating error files

basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_female"
genomes=("${basedir}/results/flye_cleaned_200/assembly.fasta" "${basedir}/results/wtdbg2_200/wtdbg2.ctg.fa")
results="${basedir}/results/quick_merge/chopped_200_assemblies"
threads=62

echo creating error files...

mkdir -p ${results}

echo Activating environment...

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/quickmerge

echo Environment activated successfully.

echo Running assembly merging....

cd $results

merge_wrapper.py ${genomes[0]} ${genomes[1]} 

echo Reads assembly completed successfully!!!

    