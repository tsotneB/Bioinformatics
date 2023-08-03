reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

filter() {
    local f=$1
    echo "Assembling $f"
    seqtk seq -L 1000 trinity_output_"$f".Trinity.fasta > transcripts_above_1kb_"$f".fasta
    echo "Assembled $f"
}

for f in $reads
do
   filter "$f" &
done
