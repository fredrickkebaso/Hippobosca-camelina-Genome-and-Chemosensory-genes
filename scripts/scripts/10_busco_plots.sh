#!/bin/bash

#To compare completeness of different genome assemblies

#Collect all the busco summary reports to a single directory  

basedir="/home/fkebaso/nfs/projects/hippo/long_reads/hcamelina_female"
reports="results/busco/genome_quality/fcs_cleaned/hcamelina_female_fcs_cleaned_genome"

mkdir -p "${basedir}/${reports}/busco_reports"

#cd ${reports}

cp ${basedir}/${reports}/*/*/*.txt "${basedir}/${reports}/busco_reports"

echo Plotting busco statistics...

python3 "${basedir}/scripts/Generate_plot.py" --working_directory "${basedir}/${reports}/busco_reports"

echo Plotting completed.