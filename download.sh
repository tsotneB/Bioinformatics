reads="SRR2241413 SRR2283829 SRR2283830 SRR2283831 SRR2283975 SRR2284246"

download () {
    local f=$1
    echo "Downloading $f"
    fastq-dump "$f" --split-files -O /home/tsotne/Desktop/arachnocampa_luminosa/Data -I -F
    sed -i '/^+HW/ s/$/\/1/' /home/tsotne/Desktop/arachnocampa_luminosa/Data/"$f"_1.fastq
    sed -i '/^+HW/ s/$/\/2/' /home/tsotne/Desktop/arachnocampa_luminosa/Data/"$f"_2.fastq
    sed -i '/^@HW/ s/$/\/1/' /home/tsotne/Desktop/arachnocampa_luminosa/Data/"$f"_1.fastq
    sed -i '/^@HW/ s/$/\/2/' /home/tsotne/Desktop/arachnocampa_luminosa/Data/"$f"_2.fastq
    echo "Downloaded $f"
}

for f in $reads
do
   download "$f" &
done
