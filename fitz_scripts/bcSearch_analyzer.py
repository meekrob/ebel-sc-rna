#!/usr/bin/env python3
import pandas as pd

def average_hamming(seqs):
    seqs = list(seqs)
    accumulative_mismatches = 0
    for i in range(len(seqs)-1):
        for j in range(i, len(seqs)):
            accumulative_mismatches += mismatches(seqs[i],seqs[j])

    return accumulative_mismatches/len(seqs)

def mismatches(s1,s2):
    n = 0
    for i in range(len(s1)):
        if s1[i] != s2[i]:
            n += 1

    return n
    
bc_output = pd.read_csv("wnv_mg8_bcSearch.csv")
result = bc_output.groupby("cell_barcode")['wnv_barcode'].apply(average_hamming)
result_df = result.reset_index(name="ave_mismatch_wnv")


variant_cells = result_df[result_df["ave_mismatch_wnv"] > 0].sort_values(by="ave_mismatch_wnv", ascending=False)

print(variant_cells.head())

result_df.to_csv("wnv_mg8_bcSearch.summary.out", index=False)


