reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

calculate () {
    local f=$1
    echo "Calculating Transcript abundancy for $f"
    salmon index -t trinity_output_"$f"/trinity_output_"$f".Trinity.fasta -i salmon_index_"$f"
    salmon quant -i salmon_index_"$f" -l ISR -1 Data/"$f"_1_filtered.fastq -2 Data/"$f"_2_filtered.fastq -o salmon_analysis_output_"$f"
    echo "Done"
}

for f in $reads
do
   calculate "$f" &
done
