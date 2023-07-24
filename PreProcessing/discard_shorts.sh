reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

discard() {
    local f=$1
    echo "Discarding reads with length less than 50 nucleotides $f"
    seqtk seq -L 50 "$f"_1_trimmed.fastq > filtered_"$f"_1_trimmed.fastq
    seqtk seq -L 50 "$f"_2_trimmed.fastq > filtered_"$f"_2_trimmed.fastq
    echo "Done Discarding $f"
}

for f in $reads
do
   discard "$f"
done
