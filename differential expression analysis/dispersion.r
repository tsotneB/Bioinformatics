options(repos = c(CRAN = "https://cloud.r-project.org"))

install.packages("edgeR")
library(edgeR)

# Read the RSEM output file for light organ samples
light_organ_rsem_file <- "SRR2283829_rsem_output.genes.results"

# Read the RSEM output file for light organ samples
rsem_data <- read.delim(light_organ_rsem_file, header = TRUE, stringsAsFactors = FALSE, row.names = 1)

# Extract gene-level expression counts
count_light <- rsem_data$expected_count

# Read the RSEM output file for light organ samples
nonlight_organ_rsem_file <- "SRR2241413_rsem_output.genes.results"

# Read the RSEM output file for light organ samples
rsem_data <- read.delim(nonlight_organ_rsem_file, header = TRUE, stringsAsFactors = FALSE, row.names = 1)

# Extract gene-level expression counts
count_nonlight <- rsem_data$expected_count

# Combine the count matrices into a single matrix
count_matrix <- cbind(count_light, count_nonlight)

# Normalize the counts
counts <- cpm(count_matrix, log = TRUE)
# Create a DGEList object
dge <- DGEList(counts = counts)

# Estimate common dispersion
dge <- estimateDisp(dge)
print(dge)