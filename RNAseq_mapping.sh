#!/bin/bash

# mapping RNA-seq reads to genome

# create directory for bowtie indices if none is present
if [ ! -d bowtie2indices ]; then
    mkdir bowtie2indices
fi

cd bowtie2indices

# create bowtie index of Stentor genome fasta if none is present
if [ ! -d StentorGenome ]; then
    mkdir StentorGenome
    bowtie2-build --seed 544 --threads 16 ../Stentor.fasta StentorGenome/StentorGenome
fi

cd ..
    
# map reads to bowtie index in local mode
mkdir RNAseq_to_genome
cd RNAseq_to_genome
bowtie2 --local --un unalignedreads.fq --al alignedreads.fq --no-unal -p 16 --seed 544 -x ../bowtie2indices/StentorGenome/StentorGenome -U ../RNAseq/1.fq,RNAseq/2.fq,RNAseq/3.fq -S readsmapped.sam 

# sam to bam
samtools view -b readsmapped.sam | samtools sort stdin > readsmapped.bam
samtools index readsmapped.bam
samtools faidx ../Stentor.fasta

# bam to bed
bedtools bamtobed -i readsmapped.bam > readsmapped.bed

# per base coverage for both strands, plus strand, minus strand
bedtools genomecov -d -ibam readsmapped.bam > genomecov_both.bed
bedtools genomecov -d -strand + -ibam readsmapped.bam > genomecov_plus.bed
bedtools genomecov -d -strand - -ibam readsmapped.bam > genomecov_minus.bed
