## Instructions

For the analysis: pysam\_analyze.py runs on the paired end read files. This directory also contains scripts to get the sizes of the files for reproducibility since the data is too large to be included in this repo. 

Do `md5sum -c md5sum.txt` to check file integrity.  Read and base count are listed in a table in this document.

### Running the analysis

Create conda environment specified in top level.

1. Link or copy fastq.gz files into this directory
2. For each pair of wnv_* files, do `python pysam_analyze.py reads1.fastq.gz reads2.fastq.gz > output.tsv`

For more information, see the header in pysam\_analyze.py.


## Data

The data are gzipped fastq files that were output from CellRanger. There was no provenance information provided, but read pairs are matched. Independant fastp analysis filters out some reads, but the scanning and selection by pysam\_analyze.py is sufficient on these files since we are applying quality standard to the barcodes only.

### File list

I compiled this table for provenance at this stage (post CellRanger).

| md5                              |   filename                      | size (bytes) | size   | total reads | total basepairs |
| -------------------------------- | ------------------------------- | ------------ | ------ | ----------- | --------------- |
| be1b86fd085a4ecc3479fd8210ed41f3 |   mg3\_c\_S3\_L001\_R1\_001.fastq.gz |  39118323886 | 36.43G |   525148879 |     79297480729 |
| c838c0933000b6ec853ba246a1f25127 |   mg3\_c\_S3\_L001\_R2\_001.fastq.gz |  40508643607 | 37.73G |   525148879 |     79297480729 |
| 09f8900902020d473752fcaccfe95b13 |   mg4\_c\_S4\_L001\_R1\_001.fastq.gz |  37124398154 | 34.57G |   488374119 |     73744491969 |
| 989ba514b47f3a767ce3dc7250ed8047 |   mg4\_c\_S4\_L001\_R2\_001.fastq.gz |  38588384510 | 35.94G |   488374119 |     73744491969 |
| 493bdbddf2c18eef5324d21898e0a844 |   mg5\_c\_S2\_L003\_R1\_001.fastq.gz |  42648770053 | 39.72G |   537529562 |     81166963862 |
| 64d70ed984932521855e1e8022675bf0 |   mg5\_c\_S2\_L003\_R2\_001.fastq.gz |  44677708913 | 41.61G |   537529562 |     81166963862 |
| 7166a712b2496f67c8b85b2bc346bddf |   mg6\_c\_S3\_L002\_R1\_001.fastq.gz |  41654480838 | 38.79G |   537560364 |     81171614964 |
| 320fe9fe7450f46d057a2e18f6e6c54a |   mg6\_c\_S3\_L002\_R2\_001.fastq.gz |  43104048850 | 40.14G |   537560364 |     81171614964 |
| 1fe8031b629bea508d9fabd0cef4a83e |   mg8\_c\_S3\_L003\_R1\_001.fastq.gz |  38349699765 | 35.72G |   491293995 |     74185393245 |
| 36a6738d5f4643e4a100c6adee1ea566 |   mg8\_c\_S3\_L003\_R2\_001.fastq.gz |  39830393914 | 37.09G |   491293995 |     74185393245 |
| f00c350d4f9775e0a1825e1e2b6dc220 |   mg9\_c\_S4\_L003\_R1\_001.fastq.gz |  40362004147 | 37.59G |   510863819 |     77140436669 |
| edea9b8bf4da71d71c0fa5220d8e421e |   mg9\_c\_S4\_L003\_R2\_001.fastq.gz |  41530093167 | 38.68G |   510863819 |     77140436669 |
| 230cbc91934ba7dd665cd76c5b9e055a | wnv\_mg3\_S1\_L001\_R1\_001.fastq.gz |  39239798339 | 36.54G |   530994115 |     80180111365 |
| 94c2110fa058c0e4aad54cb8dba9b223 | wnv\_mg3\_S1\_L001\_R2\_001.fastq.gz |  40494335334 | 37.71G |   530994115 |     80180111365 |
| 370327ca9dddf277b4f27f525768f513 | wnv\_mg4\_S2\_L001\_R1\_001.fastq.gz |  39562731300 | 36.85G |   518982659 |     78366381509 |
| a7899f5a8548c9cdb42e168d5bc19c2f | wnv\_mg4\_S2\_L001\_R2\_001.fastq.gz |  33249727494 | 30.97G |   518982659 |     78366381509 |
| 12b887792bd9f7efaa17c709901738fe | wnv\_mg5\_S1\_L003\_R1\_001.fastq.gz |  49374894919 | 46G    |   625343922 |     94426932222 |
| 9c8b41728c562db0ed16b6bef8b8db7f | wnv\_mg5\_S1\_L003\_R2\_001.fastq.gz |  52099315737 | 49G    |   625343922 | 	 94426932222 |
| 9aac1003486b11d12dc1d933e15cb1cc | wnv\_mg6\_S1\_L002\_R1\_001.fastq.gz |  44822408419 | 41.74G |   570441976 |     86136738376 |
| 3c4ff1eaa3c74cc9d449bc2f166211e8 | wnv\_mg6\_S1\_L002\_R2\_001.fastq.gz |  45605099314 | 42.47G |   570441976 |     86136738376 |
| e0918dd4150c3488ff35ddf8c8bf8c8e | wnv\_mg7\_S1\_L003\_R1\_001.fastq.gz |  43000369752 | 40.05G |   551765711 |     83316622361 |
| 17e144b5b361b9c32398d23643dade7d | wnv\_mg7\_S1\_L003\_R2\_001.fastq.gz |  44356546063 | 41.31G |   551765711 |     83316622361 |
| 3af42e1e9b89ddf8accfb70daf0f0aad | wnv\_mg8\_S2\_L003\_R1\_001.fastq.gz |  30203116535 | 28.13G |   485435325 |     73300734075 |
| 1ebddae3721463a2c51e7b547e1dc7b2 | wnv\_mg8\_S2\_L003\_R2\_001.fastq.gz |  33214637300 | 30.93G |   485435325 |     73300734075 |
| a03539ff2593ac111f395c371e44cd40 | wnv\_mg9\_S2\_L002\_R1\_001.fastq.gz |  36677575025 | 34.16G |   468776342 |     70785227642 |
| 03e68f3d35854ec5ea464ba2241f4b8b | wnv\_mg9\_S2\_L002\_R2\_001.fastq.gz |  37960933578 | 35.35G |   468776342 |     70785227642 |


### File Naming conventions

Examples: mg3_c_S3_L001_R1_001.fastq, wnv_mg7_S1_L003_R1_001.fastq


| control/virus       | S       | L00#        |  Read 1/2 | 001        |
| ------------------  | ------- | ----------- | ----------| ---------- |
| mg - mid gut <br> wnv - west nile virus | The sample number based on the order that samples are listed in the sample sheet | Lane | Read end ||
| mg#\_c or wnv_mg#\_  | S: 1-4  | L001 - L003 | R1/R2     | Always 001 |

[Illumina Naming convention](https://help.basespace.illumina.com/files-used-by-basespace/fastq-files)


