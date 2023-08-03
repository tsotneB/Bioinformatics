reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

calculate () {
    local f=$1
    echo "Calculating Transcript abundancy for $f"
    rsem-prepare-reference --bowtie ../trinity_output_"$f"/trinity_output_"$f".Trinity.fasta trinity_rsem_index
    rsem-calculate-expression --alignments --paired-end ../bowtie_output_"$f"/output_file.bam trinity_rsem_index "$f"_rsem_output
    echo "Done"
}

for f in $reads
do
   calculate "$f" &
done
