set -eu

echo Creating required files

basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male"
reads="${basedir}/results/cleaned_reads/hcamelina_male_cleaned.fastq.gz"
results="${basedir}/results/flye"
threads=58

echo creating error files...

mkdir -p ${results}

echo Activating environment...

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/flye

echo Environment activated successfully.

echo Running assembl....
    
flye --nano-raw $reads --out-dir ${results} --genome-size 130m --threads ${threads} --iterations 2 --meta 

echo Reads assembly completed successfully!!!
#-scaffold 

