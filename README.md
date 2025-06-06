## Viral Barcode Hunt

### Installation

Use conda
`conda create env -f environment.yml`

### Contents:

- **data/** - Directory to hold data for processing. It includes checksums and size analysis for provenance and meta data, but fastq files are not checked in due to size.
- **fitz_scripts/** - Review of work done so far
- **data/pysam_analyze.py** - Main fastq processing script
- **analyze_barcode_hamming.Rmd** - Main analysis script
- **analyze_barcode_hamming.pdf,html** - Knitted (formatted) output from Rmarkdown analysis
