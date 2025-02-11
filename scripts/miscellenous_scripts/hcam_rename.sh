set -eu

basedir_m="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/orthofinder/galaxy_softmasked_off/validated_genes_analysis"
basedir_f="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_female/results/orthofinder/galaxy_softmasked_off/validated_genes_analysis"

results="/home/kebaso/projects/hippo/long_reads/run_2/hcamelina_male/results/phylogenetic_analysis/gene_names"

echo Activating environment...

source /home/kebaso/miniforge3/bin/activate /home/kebaso/miniforge3/envs/seqkit

echo "Renaming hcamelina male genes..."

for file in ${basedir_m}/*.aa

do

basename=$(basename $file _genes.aa)

seqkit replace -p "hcm_" -r 'Hcamm' ${file} --out-file ${results}/${basename}_hcam.aa

cat ${results}/${basename}_hcam.aa >> ${results}/${basename}s_seq.fasta

done

echo "Done"

echo "Renaming hcamelina female genes..."

for file in ${basedir_f}/*.aa

do

basename=$(basename $file _genes.aa)

seqkit replace -p "hcf_" -r 'Hcamf' ${file} --out-file ${results}/${basename}_hcaf.aa

echo Concatenating sequence files...

cat ${results}/${basename}_hcaf.aa >> ${results}/${basename}s_seq.fasta

done

echo "Done"
 