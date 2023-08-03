from Bio import SeqIO

def split_fasta(input_file, output_prefix, num_sequences_per_file):
    with open(input_file, "r") as handle:
        records = list(SeqIO.parse(handle, "fasta"))

    print len(records)

    for i in range(0, len(records), num_sequences_per_file):
        print i
        output_file = "/Users/tamomikeladze/Desktop/split/" + output_prefix + "_" + str(i) + ".fasta"
        with open(output_file, "w") as output_handle:
            SeqIO.write(records[i:i + num_sequences_per_file], output_handle, "fasta")

if __name__ == "__main__":
    input_file = "/Users/tamomikeladze/Desktop/transcripts_above_1kb_SRR2241413.fasta"
    output_prefix = "transcripts_above_1kb_SRR2241413"  # The prefix for the output files
    num_sequences_per_file = 10  # Number of sequences per smaller file
    split_fasta(input_file, output_prefix, num_sequences_per_file)
