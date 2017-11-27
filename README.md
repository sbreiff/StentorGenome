This repository contains scripts and plots analyzing the Stentor genome.

Contents:
1. RNAseq_preprocessing.sh - script for trimming and filtering fastq files prior to mapping
2. RNAseq_mapping.sh - script for mapping to genome with Bowtie2
3. plotReadCounts.R - R script for visualizing reads mapped per contig
4. readsmapped.png - plots showing reads mapped per contig for our RNAseq data, with (1) raw counts and (2) counts normalized by contig length
5. compareReplicateLibraries.R - R script for plotting read counts from 2 replicate libraries to assess their similarity
