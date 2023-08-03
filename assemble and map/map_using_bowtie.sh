reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

map () {
    local f=$1
    echo "Mapping $f"
    bowtie-build trinity_output_"$f".Trinity.fasta b_index_"$f"
    bowtie b_index_"$f" -q -v 3 -m 1 -S ../bowtie_output_"$f"/output_file.sam -1 ../Data/"$f"_1_filtered.fastq -2 ../Data/"$f"_2_filtered.fastq
    samtools view -bS -o output_file.bam output_file.sam
    echo "Mapped $f"
}

for f in $reads
do
   map "$f" &
done
