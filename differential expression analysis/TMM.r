options(repos = c(CRAN = "https://cloud.r-project.org"))

# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install()

# install.packages("BiocManager") # If you haven't installed BiocManager
# BiocManager::install("edgeR")


# Load the required library
library(edgeR)

# Raw read counts for each sample
raw_reads <- c(44776272, 39450268, 41122414, 37092452, 40295844, 39697568)

# Sample names
sample_names <- c("Glowworm 1 light organ", "Glowworm 1 non-light organ",
                  "Glowworm 2 light organ", "Glowworm 2 non-light organ",
                  "Glowworm 3 light organ", "Glowworm 3 non-light organ")

# Create a matrix with raw read counts
data_matrix <- matrix(raw_reads, ncol = 1)

# Assign sample names to rows of the data matrix
rownames(data_matrix) <- sample_names

# Perform TMM normalization
norm_factors <- calcNormFactors(data_matrix)

# Get normalized counts
norm_counts <- cpm(data_matrix, normalization_factor = norm_factors)

# Print the normalized counts
print("Normalized raw read counts:")
print(norm_counts)
