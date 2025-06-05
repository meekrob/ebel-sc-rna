#!/usr/bin/env python3
"""
pysam_analyze.py - Read paired end fastq files using pysam library, output columns of sequences for barcodes and qualities
Pysam - https://pysam.readthedocs.io/en/latest/api.html

INSTALLATION:
    Make the conda environment in environment.yml

USAGE examples: 
    python pysam_analyze.py read1.fastq.gz read2.fastq.gz > report.tsv
    python pysam_analyze.py  wnv_mg3_S1_L001_R1_001.fastq.gz wnv_mg3_S1_L001_R2_001.fastq.gz > wnv_mg3_report.tsv
    ( shorthand for above )
    python pysam_analyze.py  wnv_mg3_S1_L001_R{1,2}_001.fastq.gz > wnv_mg3_report.tsv
"""
import sys,re
import pysam
import numpy as np

filename_r1 = sys.argv[1]
filename_r2 = sys.argv[2]

# update message only if user is running directly from terminal
print_update = False
if sys.stdin and sys.stdin.isatty():
    print_update = True

# translate the ASCII character symbol for quality into its phred33 value. 
# Phred33: probability of error = 10^-(phred33/10)
def min_qual(s): # s - string of quality symbols, like "FFFFF:FFF,"
    l = list(s)
    q = list(map(ord,l)) # ord() returns the ASCII value for a character. See ASCII character table for more info.
    return min(q) - 33   # Phred33 is the ascii value minus 33.
    

# Pattern to match the viral barcode. 3rd positions fully degenerate.
# Precompiled regular expression (faster).
pattern = re.compile("CT.AC.GT.AC.GT.AC.GC.GC.AC.CT.CT.")

# https://pysam.readthedocs.io/en/latest/api.html#pysam.FastxFile - reading fastq files
with pysam.FastxFile(filename_r1) as fh_r1, pysam.FastxFile(filename_r2) as fh_r2:  # open both files, gzip OK

    num_viruses_found = 0

    # Loop over read pair 1 and 2 simultaneously
    for i,(entry,entry_r2) in enumerate(zip(fh_r1,fh_r2)): 

        if entry.name != entry_r2.name: # like: @A00405:682:HV27LDSX5:1:1101:1072:1031
            print(f"Read pairs are not equal:\n\t{entry.name}", file=sys.stderr)
            raise "ValueError"

        # search for virus
        match = pattern.search(entry_r2.sequence)
        if match:
            s,e = match.start(), match.end()
            num_viruses_found += 1
            viral_sequence = entry_r2.sequence[s:e]
            viral_quality = entry_r2.quality[s:e]
            
            # extract barcodes by given positions (0-based; end exclusive)
            cell_sequence = entry.sequence[:15]
            umi_sequence  = entry.sequence[15:26]
            cell_quality = entry.quality[:15]
            umi_quality  = entry.quality[15:26]

            # minimum qualities with our function above
            min_cell_quality = min_qual(cell_quality)
            min_umi_quality = min_qual(umi_quality)
            min_viral_quality = min_qual(viral_quality)

            # print a tab-separated lines
            print(entry.name, cell_sequence, umi_sequence, viral_sequence, # sequence strings
                              cell_quality,  umi_quality,  viral_quality,  # quality strings
                              min_cell_quality, min_umi_quality, min_viral_quality, # min quality (single value)
                              sep="\t")

        # if running from terminal, print a message every 100,000 reads
        if print_update and (i+1) % 100000 == 0:
            msg = f" {i+1:,d} sequences processed. {num_viruses_found:,d} viral sequences"
            print(msg + "\b" * len(msg), end='',file=sys.stderr, flush=True)

# always print final summary to stderr
print(f" {i+1:,d} total sequences processed. {num_viruses_found:,d} viral sequences", file=sys.stderr)

# done
