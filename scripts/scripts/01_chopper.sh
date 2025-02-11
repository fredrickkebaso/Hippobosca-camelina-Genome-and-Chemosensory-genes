set -eu

echo Creating required files

basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male"
reads="/nfs/fkebaso/projects/hippo/long_reads/data/raw_data/hcamelina_male.fastq.gz"
results="${basedir}/results/cleaned_reads"
out_file_name="${results}/hcamelina_male_cleaned.fastq.gz"
stdout="${results}/hcamelina_male_cleaned.stdout"
threads=52

echo creating error files...

mkdir -p ${results}

echo Activating environment...

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/mambaforge/envs/chopper

echo Environment activated successfully.

echo Running porechop....

porechop --input ${reads} --output ${out_file_name} --threads 64 --check_reads 10000 --min_split_read_size 100 --verbosity 3 >> ${stdout}

#pigz --decompress --processes 64 --stdout $reads | chopper --minlength 200 --threads 64 | pigz --processes 64 >> ${results}/hcamelina_female_chopped_200_total.fastq.gz

echo Read chopping completed successfully!!!

echo "started flye for hcamelina male" 

bash /nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male/scripts/flye.sh

echo "Completed hcamelina male sample analysis"




