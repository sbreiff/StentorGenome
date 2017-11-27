# Script for visualizing RNAseq mapping patterns

require(ggplot2)
require(gridExtra)

# read in data
rpc <- read.table('read_counts.txt')
colnames(rpc) <- c('contig', 'length', 'reads')
rpc$reads_per_length <- (rpc$reads / rpc$length) * 1000

# plot log2 reads per contig
plot1 <- ggplot(rpc, aes(x=as.numeric(rownames(rpc)), y=log2(reads + 1))) +
  geom_point() + ylim(0,24) + xlab("contig") + ylab("log2 reads") + 
  ggtitle("Reads mapped per contig")

# plot log2 reads per contig, per kb
plot2 <- ggplot(rpc, aes(x=as.numeric(rownames(rpc)), y=log2(reads_per_length + 1))) + 
  geom_point() + ylim(0,24) + xlab("contig") + ylab("log2 reads per kb") +
  ggtitle("Reads mapped per contig per length")

# combine 2 plots in 1 window
grid.arrange(plot1, plot2, ncol=2)




