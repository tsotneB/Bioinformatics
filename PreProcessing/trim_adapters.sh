reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

trim_adapters() {
    local f=$1
    echo "Processing $f"
    fastq-mcf -q 20 -o "$f"_1_trimmed.fastq -o "$f"_2_trimmed.fastq adapters.fa "$f"_1.fastq "$f"_2.fastq
    echo "Done processing $f"
}

for f in $reads
do
   trim_adapters "$f"
done
