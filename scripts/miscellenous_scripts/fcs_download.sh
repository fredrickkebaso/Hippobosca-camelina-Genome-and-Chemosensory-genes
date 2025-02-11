#Download FCS-GX

#curl -LO https://github.com/ncbi/fcs/raw/main/dist/fcs.py

#Download the FCS-GX database

#SOURCE_DB_MANIFEST="https://ncbi-fcs-gx.s3.amazonaws.com/gxdb/latest/all.manifest"
#LOCAL_DB="/mnt/lustre/users/fkebaso/hippo/long_reads/hcamelina_male/data/databases"
#python3 fcs.py db get --mft "$SOURCE_DB_MANIFEST" --dir "$LOCAL_DB/gxdb"

cd /home/fkebaso/nfs/projects/hippo/long_reads/data/databases

source /opt/conda/bin/activate /home/fkebaso/.conda/envs/fcs

curl -LO https://github.com/peak/s5cmd/releases/download/v2.0.0/s5cmd_2.0.0_Linux-64bit.tar.gz
tar -xvf s5cmd_2.0.0_Linux-64bit.tar.gz

LOCAL_DB="/home/fkebaso/nfs/projects/hippo/long_reads/data/databases"

./s5cmd  --no-sign-request cp  --part-size 50  --concurrency 50 s3://ncbi-fcs-gx/gxdb/latest/all.* $LOCAL_DB

#Running genome contamination check....

