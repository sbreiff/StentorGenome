#!/bin/bash

# Usage: bash RNAseq.sh <infile.fq> <outfile_rootname>

CURR_DIR=$(pwd)

echo "Clipping 3' adapters off $1"
# clip adapters off 3' end of read (readthrough)
cutadapt -a TGGAATTCTCGGGTGCCAAGGAACTCCAGTCAC $1 > $2_cut.fq

cd ../../..

echo "Clipping 5' adapters off $1"
# clip adapters off of 5' end of read
# min quality score of 30 to keep bases at 5' and 3' end of read
# throw out reads less than 22 bases long
java -jar Trimmomatic-0.27/trimmomatic-0.27.jar SE -phred33 -threads 6 $CURR_DIR/$2_cut.fq $CURR_DIR/$2_cuttrim.fq ILLUMINACLIP:RNA5p_adapter.fa:2:30:10 LEADING:30 TRAILING:30 MINLEN:22

cd $CURR_DIR
rm $2_cut.fq

echo "Trimming and quality filtering $1"
# 3rd base is first base to keep (based on FastQC report)
# throw out reads less than 20 bases long
# throw out reads in which 50% of bases are quality 30 or lower
fastx_trimmer -Q33 -f 3 -m 20 -v -i $2_cuttrim.fq | fastq_quality_filter -Q33 -q 30 -p 50 -v -o $2_cuttrim2.fq
rm $2_cuttrim.fq

echo "FastQC analysis in progress"
FastQC/fastqc $2_cuttrim2.fq -k 8 -t 6

echo "Read trimming complete."
