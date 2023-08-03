reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

analysis() {
    local f=$1
    fastqc "$f"_1_filtered.fastq
    fastqc "$f"_2_filtered.fastq
}

for f in $reads
do
   analysis "$f"
done
