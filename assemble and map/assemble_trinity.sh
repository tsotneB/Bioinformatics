reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

assemble () {
    local f=$1
    echo "Assembling $f"
    ./Trinity --seqType fq --left ../../Data/"$f"_1_filtered.fastq --right ../../Data/"$f"_2_filtered.fastq --SS_lib_type RF --max_memory 10G --output ../../trinity_output_"$f"
    echo "Assembled $f"
}

for f in $reads
do
   assemble "$f" &
done
