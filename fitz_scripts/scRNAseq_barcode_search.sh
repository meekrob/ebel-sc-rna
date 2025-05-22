# scRNAseq file barcode search
# 7/26/24
# Fitzmeyer

# THIS SCRIPT ASSUMES SYNCHRONOUS R1 AND R2 FILES 

# define arguments passed as 'file_base'
# if fastq file is sampleID_S1_L001_R1_001.fastq, then file_base = "sampleID_S1_L001"
file_base=$@

mkdir ${file_base}

# alert the user if input is not supplied
if [ $# == 0 ]
then
	echo -e "barcode search>>>>> ERROR>>>>>
	Please provide input like so: ./this_script arg_S#_L003"
fi

# print greeting if input is supplied
if [ $# -gt 0 ]
then
	echo -e "Processing sample: $file_base"
	date
fi

for file_base in ${file_base[@]}
do

	# define R1 and R2 files
	R2_fastq=${file_base}_R2_001.fastq.gz
	R1_fastq=${file_base}_R1_001.fastq.gz

	# define R2 output file name
	output_file_R2=${file_base}_bcSearch_R2.fastq

	# zgrep (unzipping these files is a nightmare) barcode pattern + read header and read into output file
	# use sed to set consistent delimeter between header/sequence and line number 
	zgrep "CT.AC.GT.AC.GT.AC.GC.GC.AC.CT.CT." -a -B 1 -n --no-group-separator $R2_fastq | sed 's/^\([0-9]\+\)-/\1:/' > $output_file_R2
	
	echo -e "barcode search completed"
	date
	
	# define line number output file name
	line_number_file=${file_base}_line_numbers.txt
	
	# extract line numbers from $output_file_R2
	cut -d: -f1 $output_file_R2 > $line_number_file
	
	echo -e "line numbers extracted"
	date
	
	# define R1 output file name
	output_file_R1=${file_base}_bcSearch_R1.fastq
	
	# unzip the R1 file (awk command doesn't work on zipped file)
	pigz -dk $R1_fastq
	
	# define decompressed R1 file
	R1_fastq_dec=${file_base}_R1_001.fastq
	
	# extract desired lines from R1 file using line numbers from the line numbers file
	awk 'NR==FNR{a[$0]=1;next}a[FNR]' $line_number_file $R1_fastq_dec > $output_file_R1
	
	echo -e "R1 reads extracted"
	date
	
	# remove line numbers from R2 file
	output_file_R2_noN=${file_base}_bcSearch_R2_noN.fastq
	cut -d: -f2- $output_file_R2 > $output_file_R2_noN
	
	# re-zip the R1 file? No need if using -dk flag with pigz (k=keep, keeps original compressed file)
	
	# define cell barcode whitelist
	#cell_barcode_whitelist=~/cell_ranger/apps/cellranger-7.0.1/lib/python/cellranger/barcodes/737K-august-2016.txt
	
	# grep $output_file_R1 for each barcode from whitelist - 
	#grep -F $cell_barcode_whitelist 
		
	# move output files into $file_base directory
	mv $output_file_R2_noN ${file_base}/$output_file_R2_noN
	mv $output_file_R2 ${file_base}/$output_file_R2
	mv $output_file_R1 ${file_base}/$output_file_R1
	mv $line_number_file ${file_base}/$line_number_file
	
done	
	
# tell the user the script is done
echo -e "Done"
date

# read R1 and R2 output files into tempName.R 


