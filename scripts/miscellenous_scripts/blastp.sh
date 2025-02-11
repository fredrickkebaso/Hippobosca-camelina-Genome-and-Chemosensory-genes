database="/nfs/fkebaso/projects/hippo/data/databases/NCBI/non-redundant_db/indexed_db"
basedir="/nfs/fkebaso/projects/hippo/long_reads/run_2/hcamelina_male"
query=${basedir}/results/blast_test/blast_test.fa

blastp \
-query ${query} \
-db ${database} \
-out blast_test.txt \
-evalue 0.001 \
-outfmt 10 \
-html \
-max_target_seqs 10 \
-export_search_strategy blast_search_strategy.txt 
