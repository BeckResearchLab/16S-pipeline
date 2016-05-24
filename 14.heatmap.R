#source("ggplot-heatmap.R")
source("heatmap.3.R")
#library(gplots)
library(vegan)
library(RColorBrewer)
#library(gplots)
#library(DESeq2)
#library(fdrtool)
#library(MASS)
library(ggplot2)
#library(reshape)

sample_read_sums <- read.table("12.normalize.read_sums.xls", header=T, sep="\t", row.names=1)
sample_read_sums
dim(sample_read_sums)

best.tax <- read.table("13.best_tax.xls", header=T, sep='\t', row.names=1)
best.tax$desc <- sprintf("%s : %s (%s, %.2g)", rownames(best.tax), best.tax$best_tax, best.tax$best_tax_level, best.tax$best_tax_confidence)

best.tax$desc

raw_otus <- read.table("syncom50.xls", header=T, sep='\t', row.names=1)
raw_otus <- raw_otus[, -which(names(raw_otus) %in% c("domain", "domain_confidence", "phylum", "phylum_confidence", "class", "class_confidence", "order_", "order_confidence", "family", "family_confidence", "genus", "genus_confidence", "species", "species_confidence", "sequence"))]
head(raw_otus)
dim(raw_otus)

otus_pcnt <- scale(raw_otus, center=FALSE, scale=t(sample_read_sums))
head(otus_pcnt)
otus_pcnt <- otus_pcnt[apply(otus_pcnt[,-1], 1, function(x) !all(x==0)),]

dim(otus_pcnt)

#otus_pcnt

log_otus <- read.table("syncom50.log_normalized.xls", header=T, sep='\t', row.names=1)
log_otus <- log_otus[, -which(names(log_otus) %in% c("domain", "domain_confidence", "phylum", "phylum_confidence", "class", "class_confidence", "order_", "order_confidence", "family", "family_confidence", "genus", "genus_confidence", "species", "species_confidence", "sequence"))]
head(log_otus)

#log_otus <- log_otus[apply(log_otus[,-1], 1, function(x) !all(x==0)),]

log_otus <- log_otus[row.names(otus_pcnt),]

dim(log_otus)

#log_otus

pdf("./14.heatmap.pdf")

rownames(log_otus) <- best.tax[rownames(log_otus), "desc"]

heatmap.3(as.matrix(log_otus), as.matrix(otus_pcnt), key=T, distfun=vegdist, col=brewer.pal(9, "YlGnBu"), hclustfun = function(x) hclust(x,method = 'average'), scale='none', na.rm=T, na.color="white", density.info='none', trace='none', KeyValueName="ln Reads", symkey=F, symbreaks=F, sepcolor="lightgrey", rowsep=c(1:100), colsep=c(1:100))

dev.off()


