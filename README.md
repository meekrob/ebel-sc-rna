## Viral Barcode Hunt

### After filtering anomalous UMI/barcode pairs, there are few cells with distinct viral barcodes

![Main figure showing lack of viral diversity after UMI anomaly filtering](/viral_diversity_cells_after_UMI_filtering.png)

### Installation

Use conda
`conda create env -f environment.yml`

### Contents:

- **data/** - Directory to hold data for processing. It includes checksums and size analysis for provenance and meta data, but fastq files are not checked in due to size.
- **fitz_scripts/** - Review of work done so far
- **data/pysam_analyze.py** - Main fastq processing script
- **analyze_barcode_hamming.Rmd** - Main analysis script
- **analyze_barcode_hamming.pdf,html** - Knitted (formatted) output from Rmarkdown analysis
