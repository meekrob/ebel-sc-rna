## Viral Barcode Hunt

### After filtering anomalous UMI/barcode pairs, there are few cells with distinct viral barcodes

![Main figure showing lack of viral diversity after UMI anomaly filtering](/viral_diversity_cells_after_UMI_filtering.png)

### Installation

#### R/RStudio

No requirements

#### fastq file processing

Use conda
`conda create env -f environment.yml`

### Quick Instructions

#### R/RStudio

Run the RMarkdown analyze\_barcode\_hamming.Rmd

#### fastq file processing

Preferably on a linux server, link the fastq files in the data directory and run `python pysam_analyze.py`. 
Further instructions are in that directory.


### Contents:

- **reports/** - Directory to hold the tsv files (output from pysam\_analyze.py; input for analyze\_barcode\_hamming.Rmd)
- **data/** - Directory to hold data for processing. It includes checksums and size analysis for provenance and meta data, but fastq files are not checked in due to size.
- **fitz_scripts/** - Review of work done so far
- **data/pysam_analyze.py** - Main fastq processing script
- **analyze_barcode_hamming.Rmd** - Main analysis script
- **analyze_barcode_hamming.pdf,html** - Knitted (formatted) output from Rmarkdown analysis
