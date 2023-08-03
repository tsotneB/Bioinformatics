import pandas as pd
import numpy as np
from scipy import stats
import statsmodels.stats.multitest as mt

# Read the RSEM output files into DataFrames
light_df1 = pd.read_csv("SRR2283975_rsem_output.genes.results", sep="\t")
light_df2 = pd.read_csv("SRR2241413_rsem_output.genes.results", sep="\t")
non_light_df1 = pd.read_csv("SRR2283829_rsem_output.genes.results", sep="\t")
non_light_df2 = pd.read_csv("SRR2284246_rsem_output.genes.results", sep="\t")

light_df1 = light_df1[["gene_id", "expected_count"]]
light_df2 = light_df2[["gene_id", "expected_count"]]

non_light_df1 = non_light_df1[["gene_id", "expected_count"]]
non_light_df2 = non_light_df2[["gene_id", "expected_count"]]

# Combine the two DataFrames by "gene_id"
light_df = light_df1.merge(light_df2, on="gene_id", how="outer")

# Add the expected_count values for each gene
light_df["expected_count"] = light_df["expected_count_x"] + light_df["expected_count_y"]

# Drop the "expected_count_x" and "expected_count_y" columns
light_df = light_df.drop(["expected_count_x", "expected_count_y"], axis=1)



# Combine the two DataFrames by "gene_id"
non_light_df = non_light_df1.merge(non_light_df2, on="gene_id", how="outer")

# Add the expected_count values for each gene
non_light_df["expected_count"] = non_light_df["expected_count_x"] + non_light_df["expected_count_y"]

# Drop the "expected_count_x" and "expected_count_y" columns
non_light_df = non_light_df.drop(["expected_count_x", "expected_count_y"], axis=1)


# Calculate the log2 fold change for each gene
log2_fold_change = (light_df["expected_count"] - non_light_df["expected_count"]) / non_light_df["expected_count"]

# Calculate the p-value for each gene
p_value = 2 * np.min(
    [
        1 - stats.norm.cdf(abs(log2_fold_change)),
        1 - stats.norm.cdf(-abs(log2_fold_change)),
    ]
)

p_value_bh, alphacSidak, alphacBonf, reject = mt.multipletests(p_value, alpha=0.1, method="fdr_bh")
reject_bool = np.asarray(reject, dtype=bool)
significant_genes = light_df[
    (p_value_bh < 0.1) & (log2_fold_change > 1) & reject_bool
]

significant_genes = significant_genes.sort_values(by="expected_count", ascending=False)
# Print the list of significant genes
print(significant_genes)
significant_genes.to_csv("Benjamini-Hochberg_sorted.csv", index=True)


