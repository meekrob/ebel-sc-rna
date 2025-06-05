#
# Makefile - makes seqtk_size/filename.size for every fastq.gz in the current directory
# USAGE:  Just type 'make'
SEQSIZE_DIR=seqtk_size
F=$(wildcard *.fastq.gz)
S=$(addprefix ${SEQSIZE_DIR}/, $(addsuffix .size,$F))

default: $S

${SEQSIZE_DIR}/%.fastq.gz.size: %.fastq.gz
	@bash make_readcounts.sh $^
	mv ${^}.size $@

