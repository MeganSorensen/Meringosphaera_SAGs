library('ggplot2')
library('stringr')
library("seqinr")
# Compare the gene set of the plastids

# First read in the SAG annotations 
setwd("") #Set working directory
df_S2 <- as.data.frame(read.csv('')) #name of input sample files
df_S3 <- as.data.frame(read.csv('')) #name of input sample files
df_S4 <- as.data.frame(read.csv('')) #name of input sample files
df_S6 <- as.data.frame(read.csv('')) #name of input sample files
df_S8 <- as.data.frame(read.csv('')) #name of input sample files
df_S14 <- as.data.frame(read.csv('')) #name of input sample files

# Function that pulls out the gene names from the annotation file
gene_list <- function(x) {
  gene_list <- c()
  for (i in 1:nrow(x)){
    if (x$Type[i] == 'gene'){
      gene_found <- x$ID[i]
      gene_list <- c(gene_list, gene_found)
    }}
  gene_list #returns 
}

#Apply function to all SAGs
gene_list_S2 <- gene_list(df_S2)
gene_list_S3 <- gene_list(df_S3)
gene_list_S4 <- gene_list(df_S4)
gene_list_S6 <- gene_list(df_S6)
gene_list_S8 <- gene_list(df_S8)
gene_list_S14 <- gene_list(df_S14)

#Check the total number of genes, and make the list unique 
SAG_set_genes <- c(gene_list_S2, gene_list_S3, gene_list_S4, gene_list_S6, gene_list_S8,gene_list_S14)
SAG_set_genes  <- unique(SAG_set2_genes) #143 unique genes


###########################  Dictyochophyceae Reference genomes
# For the reference genomes need to extract genes from downloaded fasta file
# Use a series of string splits to access the name
extract_genes <- function(x){
  gene_list <- c()
  for (i in 1:length(getAnnot(x))){
    name <- getAnnot(x)[[i]]
    entry<- strsplit(name,"\\[")[[1]][2]
    ver2<- strsplit(entry,"=")[[1]][2]
    gene<-strsplit(ver2,"\\]")[[1]][1]
    gene_list <- c(gene_list, gene)  
  }
  gene_list #Returns the last line
}

setwd("")   #path to reference genomes 
Fp <- read.fasta('MK518352_genes.fasta')  #Name of reference file
Pe <- read.fasta('MK518353_genes.fasta')  #Name of reference file
Ds <- read.fasta('MK561359_genes.fasta')  #Name of reference file
Rm <- read.fasta('MK561360_genes.fasta')  #Name of reference file

#Apply the extract genes function
genes_Fp <- extract_genes(Fp)
genes_Pe <- extract_genes(Pe)
genes_Ds <- extract_genes(Ds)
genes_Rm <- extract_genes(Rm)

#Combine total genes, and make the list unique
dicty_genes <- c(genes_Fp, genes_Pe, genes_Ds,genes_Rm)
dicty_genes <- unique(dicty_genes) #163 total  

############################ Compare the reference and SAG genomes   

setwd("")   #Set working directory

#combine total gene lists from dicty and SAGs, check number of unique genes
gene_list <- c(SAG_set_genes, dicty_genes)
gene_list <- unique(gene_list) #total 178
gene_list <- sort(gene_list)

#Make empty lists per genome, length = total number of unique genes = 178
SAG_S2 <- vector("list", 178)
SAG_S3 <- vector("list", 178)
SAG_S4<- vector("list", 178)
SAG_S6 <- vector("list", 178)
SAG_S8<- vector("list", 178)
SAG_S14 <- vector("list", 178)
Fp_set <- vector("list", 178)
Pe_set <- vector("list", 178)
Ds_set <- vector("list", 178)
Rm_set <- vector("list", 178)

#Check presence of every gene in every genome
for (i in 1:length(gene_list)){
  gene <- gene_list[i]
  if (gene %in% gene_list_S2){SAG_S2[i] <- length(which(gene_list_S2 == gene))}  else {SAG_S2[i] <- 0}
  if (gene %in% gene_list_S3){SAG_S3[i] <- length(which(gene_list_S3 == gene))}  else {SAG_S3[i] <- 0}
  if (gene %in% gene_list_S4){SAG_S4[i] <- length(which(gene_list_S4 == gene))}  else {SAG_S4[i] <- 0}
  
  if (gene %in% gene_list_S6){SAG_S6[i] <- length(which(gene_list_S6 == gene))}  else {SAG_S6[i] <- 0}
  if (gene %in% gene_list_S8){SAG_S8[i] <- length(which(gene_list_S8 == gene))}  else {SAG_S8[i] <- 0}
  if (gene %in% gene_list_S14){SAG_S14[i] <- length(which(gene_list_S14 == gene))}  else {SAG_S14[i] <- 0}
  
  if (gene %in% genes_Fp){Fp_set[i] <- length(which(genes_Fp == gene))}  else {Fp_set[i] <- 0}
  if (gene %in% genes_Pe){Pe_set[i] <- length(which(genes_Pe == gene))}  else {Pe_set[i] <- 0}
  if (gene %in% genes_Ds){Ds_set[i] <- length(which(genes_Ds == gene))}  else {Ds_set[i] <- 0}
  if (gene %in% genes_Rm){Rm_set[i] <- length(which(genes_Rm == gene))}  else {Rm_set[i] <- 0}
}

#Group results together
df_compare_genes <- as.data.frame(cbind(gene_list,unlist(SAG_S2),unlist(SAG_S3),unlist(SAG_S4),
                                        unlist(SAG_S6),unlist(SAG_S8),unlist(SAG_S14),
                                        unlist(Fp_set),unlist(Pe_set),unlist(Ds_set),unlist(Rm_set)  ))

colnames(df_compare_genes) <- c('genes', 'SAG_S2','SAG_S3','SAG_S4',
                                'SAG_S6','SAG_S8','SAG_S14',
                                'F.parvula','P.elastica','D.speculum','R.marina')

write.csv(df_compare_genes,'df_compare_genes.csv') #Write output as csv


########################### Plot
library('ggplot2')
setwd("")   #Set working directory
df_compare_genes <- as.data.frame(read.csv('df_compare_genes.csv')) #read in result file


##### Make grid style figure
compare_genes <- as.data.frame(read.csv('df_compare_genes.csv')) 

# install.packages("reshape")
library(reshape)

# Transform the matrix into long format df
df <- melt(compare_genes)
colnames(df) <- c("gene", "Sample", "Presence")

#For this figure, gene copy number is not necessary, so set all copies >1 to 1
df$Presence[df$Presence>=2] <- 1

#Change presence number based on the identity, so that can colour code (1 = SAG gr1, 2 =SAG gr2 & 3 = Dicty)
for (i in 1:nrow(df)){
  if (df$Presence[i] == 1){
    if (df$Genome[i] == "SAG_S2" | df$Genome[i] == "SAG_S3" | df$Genome[i] == "SAG_S6" ){df$Presence[i] <- 1}
    if (df$Genome[i] == "SAG_S4" | df$Genome[i] == "SAG_S8" | df$Genome[i] == "SAG_S14" ){df$Presence[i] <- 2}
    if (df$Genome[i] == "R.marina" | df$Genome[i] == "F.parvula" | df$Genome[i] == "P.elastica"| df$Genome[i] == "D.speculum" ){df$Presence[i] <- 3}
  }}

#Format the df for the plot, set order of genomes
df$Presence <- as.character(df$Presence)
df$Genome <- factor(df$Genome , levels = c ("SAG_S2","SAG_S3","SAG_S6","SAG_S4","SAG_S8","SAG_S14","F.parvula","P.elastica", 
                                            "D.speculum", "R.marina" ))
#Set the order of the genes to be reverse so that you read top to bottom
df$Genes <- factor(df$Genes,levels = rev(df_compare$genes)) 

#Full grid plot
pall <- ggplot(df, aes(x = Genome, y = Genes, fill = Presence)) +
  geom_tile(color = "white", 
            linetype = 1) +
  coord_fixed() + #keep as squares
  scale_fill_manual(name = "",  values = c("white", "darkseagreen3", "darkgreen", "cadetblue"),
                    labels = c("","Group 1 SAGs", "Group 2 SAGs", "Dictyochophyceae")) +
  theme(axis.text.x = element_text(angle = 45, hjust=1, size = 5))   

#Save plot
ggsave("Plastid_genomes_grid.png", plot=pall, height=50, width=20, units=c("cm"), dpi=300)



