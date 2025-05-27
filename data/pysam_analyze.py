#!/usr/bin/env python3
import sys,re
import pysam
import numpy as np

filename_r1 = sys.argv[1]
filename_r2 = sys.argv[2]

print_update = False
if sys.stdin and sys.stdin.isatty():
    print_update = True

def min_qual(s):
    l = list(s)
    q = list(map(ord,l))
    return min(q) - 33
    

pattern = re.compile("CT.AC.GT.AC.GT.AC.GC.GC.AC.CT.CT.")

with pysam.FastxFile(filename_r1) as fh_r1, pysam.FastxFile(filename_r2) as fh_r2: 
    num_viruses_found = 0
    for i,(entry,entry_r2) in enumerate(zip(fh_r1,fh_r2)): 

        if entry.name != entry_r2.name:
            print(f"Read pairs are not equal:\n\t{entry.name}", file=sys.stderr)
            raise "ValueError"

        # search for virus
        match = pattern.search(entry_r2.sequence)
        if match:
            s,e = match.start(), match.end()
            num_viruses_found += 1
            viral_sequence = entry_r2.sequence[s:e]
            viral_quality = entry_r2.quality[s:e]
            
            # barcodes
            cell_sequence = entry.sequence[:15]
            umi_sequence  = entry.sequence[15:26]
            cell_quality = entry.quality[:15]
            umi_quality  = entry.quality[15:26]

            # quality
            min_cell_quality = min_qual(cell_quality)
            min_umi_quality = min_qual(umi_quality)
            min_viral_quality = min_qual(viral_quality)

            print(entry.name, cell_sequence, umi_sequence, viral_sequence, cell_quality, umi_quality, viral_quality, min_cell_quality, min_umi_quality, min_viral_quality, sep="\t")
            #break

        if print_update and (i+1) % 100000 == 0:
            msg = f" {i+1:,d} sequences processed. {num_viruses_found:,d} viral sequences"
            print(msg + "\b" * len(msg), end='',file=sys.stderr, flush=True)

print(f" {i+1:,d} total sequences processed. {num_viruses_found:,d} viral sequences", file=sys.stderr)
