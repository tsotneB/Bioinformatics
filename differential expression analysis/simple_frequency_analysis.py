import pandas as pd
import numpy as np
import scipy.stats as stats
from statsmodels.stats.multitest import multipletests

file_path = 'SRR2241413_rsem_output.genes.results'

# Read the file into a DataFrame
df = pd.read_csv(file_path, sep='\t')

df.columns = ['gene_id', 'transcript_id', 'length', 'effective_length', 'expected_count', 'TPM', 'FPKM']

columns_to_keep = ['gene_id', 'transcript_id', 'expected_count']
light_df = df[columns_to_keep]

print(light_df.head())


nl_file_path = 'SRR2283829_rsem_output.genes.results'

# Read the file into a DataFrame
nl_df = pd.read_csv(nl_file_path, sep='\t')

nl_df.columns = ['gene_id', 'transcript_id', 'length', 'effective_length', 'expected_count', 'TPM', 'FPKM']

nonlight_df = nl_df[columns_to_keep]
print(nonlight_df.head())


merged_df = light_df.merge(nonlight_df, on='gene_id', how='outer', suffixes=('_light', '_nonlight'))

# Fill missing values with 0
merged_df['expected_count_light'] = merged_df['expected_count_light'].fillna(0)
merged_df['expected_count_nonlight'] = merged_df['expected_count_nonlight'].fillna(0)

print(merged_df.columns)
# Drop duplicate columns (gene_id and transcript_id from the second dataframe)
merged_df.drop(['transcript_id_light', 'transcript_id_nonlight'], axis=1, inplace=True)

merged_df.rename(columns={'gene_id_light': 'gene_id', 'expected_count_light': 'count_light', 'expected_count_nonlight': 'count_nonlight'}, inplace=True)




file_path1 = 'SRR2283975_rsem_output.genes.results'

# Read the file into a DataFrame
df1 = pd.read_csv(file_path1, sep='\t')

df1.columns = ['gene_id', 'transcript_id', 'length', 'effective_length', 'expected_count', 'TPM', 'FPKM']

columns_to_keep1 = ['gene_id', 'transcript_id', 'expected_count']
light_df1 = df1[columns_to_keep1]

# Display the DataFrame
print(light_df1.head())


nl_file_path1 = 'SRR2283829_rsem_output.genes.results'

# Read the file into a DataFrame
nl_df1 = pd.read_csv(nl_file_path1, sep='\t')

nl_df1.columns = ['gene_id', 'transcript_id', 'length', 'effective_length', 'expected_count', 'TPM', 'FPKM']

nonlight_df1 = nl_df1[columns_to_keep1]
print(nonlight_df1.head())


merged_df1 = light_df.merge(nonlight_df1, on='gene_id', how='outer', suffixes=('_light', '_nonlight'))

# Fill missing values with 0
merged_df1['expected_count_light'] = merged_df1['expected_count_light'].fillna(0)
merged_df1['expected_count_nonlight'] = merged_df1['expected_count_nonlight'].fillna(0)

print(merged_df1.columns)
# Drop duplicate columns (gene_id and transcript_id from the second dataframe)
merged_df1.drop(['transcript_id_light', 'transcript_id_nonlight'], axis=1, inplace=True)

merged_df1.rename(columns={'gene_id_light': 'gene_id', 'expected_count_light': 'count_light', 'expected_count_nonlight': 'count_nonlight'}, inplace=True)


# Concatenate the DataFrames
combined_df = pd.concat([merged_df, merged_df1], ignore_index=True)

# Group by "gene_id" and sum the counts for matching rows
result_df = combined_df.groupby("gene_id", as_index=False).sum()

print(result_df)



result_df['count_diff'] = result_df['count_light'] - result_df['count_nonlight']

filtered_df = result_df[result_df['count_diff'] > 0]

# Sort the filtered dataframe based on the 'count_diff' column in descending order
sorted_df = filtered_df.sort_values(by='count_diff', ascending=False)

# Display the sorted dataframe
print(sorted_df)
sorted_df.to_csv("sorted.csv", index=True)
