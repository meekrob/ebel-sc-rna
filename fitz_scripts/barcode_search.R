library(tidyverse)

fq_R1 <- read_csv("/Users/emilyfitzmeyer/Desktop/in_silico_polyinfection/fastqs/wnv_mg9_S2_L002_bcSearch_R1.fastq", col_names = "read1")
fq_R2 <- read_csv("/Users/emilyfitzmeyer/Desktop/in_silico_polyinfection/fastqs/wnv_mg9_S2_L002_bcSearch_R2_noN.fastq", col_names = "read2")

tib <- tibble(fq_R1, fq_R2)

#either this or comment='@' would work to remove headers. 
tib <- tib[!grepl("@", tib$read1),]

#Extract cell barcode, umi, and wnv barcode from reads
tib <- tib %>%
  mutate(cell_barcode = substr(tib$read1, 1,16)) %>%
  mutate(umi = substr(tib$read1, 17,27)) %>%
  mutate(wnv_barcode = str_extract(tib$read2, "CT.AC.GT.AC.GT.AC.GC.GC.AC.CT.CT."))

write.csv(tib, "/Users/emilyfitzmeyer/Desktop/wnv_mg9_bcSearch.csv")

#Replace 'N' with '.'
#Grep each in cell barcode whitelist
#Append whitelist match to dataframe (keep paired w/ OG barcode)

#Goal is to have a dataframe with barcode sequences and their associated UMIs and cell barcodes

