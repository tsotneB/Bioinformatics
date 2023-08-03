reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

discard() {
    local f=$1
    echo "Discarding reads with length less than 50 nucleotides $f"

    fastp -i "$f"_1_trimmed.fastq -I "$f"_2_trimmed.fastq -o "$f"_1_filtered.fastq -O "$f"_2_filtered.fastq -l 50

    echo "Done Discarding $f"
}

for f in $reads
do
   discard "$f"
done
