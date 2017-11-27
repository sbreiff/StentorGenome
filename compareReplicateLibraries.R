library(ggplot2)

# read in data
# table contains gene id, gene length, reads from sample 1 (S1),
#      reads from sample 2 (S2)
counts <- read.table('transcriptome_counts.txt', header=TRUE)

# add 1 to read counts so we can log transform later
counts$S1corr <- counts$S1 + 1
counts$S2corr <- counts$S2 + 1

# calculate reads per kb to normalize for gene length
counts$S1_rpk <- counts$S1corr / counts$length * 1000
counts$S2_rpk <- counts$S2corr / counts$length * 1000

# calculate TPM to normalize for # of reads per library
counts$S1_tpm <- counts$S1_rpk / sum(counts$S1corr) * 1000000
counts$S2_tpm <- counts$S2_rpk / sum(counts$S2corr) * 1000000

# scatterplot
ggplot(counts, aes(x=log2(counts$g_tpm), y=log2(counts$c_tpm))) + 
  geom_point() + xlab("Sample 1") + ylab("Sample 2") + 
  ggtitle("Read counts from 2 replicate libraries")