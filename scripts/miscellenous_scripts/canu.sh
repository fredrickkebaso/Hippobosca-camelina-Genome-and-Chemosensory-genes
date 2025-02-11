#PBS -l select=2:ncpus=56:mpiprocs=56:mem=800gb
#PBS -q bigmem
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -o /mnt/lustre/users/fkebaso/hippo/long_reads/hcamelina_male/results/canu/canu.out
#PBS -e /mnt/lustre/users/fkebaso/hippo/long_reads/hcamelina_male/results/canu/canu.err
#PBS -m abe
#PBS -M fredrickkebaso@gmail.com
#PBS -N canu

set -eu

echo Creating required files

basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_male"
reads="${basedir}/data/raw/fastq/hcamelina_male_total_fastq.gz"  #hcamelina_male.fastq.gz
results="${basedir}/results/canu"
threads=64

echo creating error files...

mkdir -p ${results}

touch ${results}/canu.err ${results}/canu.out

echo Activating environment...

source /home/fkebaso/mambaforge/bin/activate /home/fkebaso/y/envs/canu

echo Environment activated successfully.

echo Running assembl....
    
canu -d ${results} -p "hcamelina_male" genomeSize=155m -nanopore-raw $reads useGrid=false minReadLength=400 minOverlapLength=400 gnuplotTested=true 

echo Reads assembly completed successfully!!!

    
