#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools
module load samtools/1.9
module load bwa/0.7.8 

### Variables
REF=	#Path for the assembly 
READ1=	#Path for the forward reads
READ2=	#Path for the reverse reads 
OUTDIR=		#Path for the output directory
Append1= 	#Short name for the assembly
Append2=	#Short name for the reads
SAMPLE=BWA_${Append1}-vs-${Append2} # Name of output files

# Make temp dir for mapping
MAPDIR_temp=$SNIC_TMP/bwa
mkdir $MAPDIR_temp
cd $MAPDIR_temp
cp $REF .
bwa index $REF


##  BWA FLAGS:
	## -M to flag shorter split hits as secondary.
	## -C but keep comments
	## -v 3 verbose level normal messages

## run BWA on paired reads
bwa mem -t 5 -M -v 3 $REF $READ1 $READ2 > $MAPDIR_temp/${SAMPLE}.sam  

#for normal Illumina reads: convert to bam 
samtools view -@ 5 -b -S $MAPDIR_temp/${SAMPLE}.sam > $MAPDIR_temp/${SAMPLE}.bam


#sort
samtools sort -@ 5 -o $MAPDIR_temp/${SAMPLE}_sorted.bam $MAPDIR_temp/${SAMPLE}.bam 

# Sync to output directory
rsync -av $MAPDIR_temp/${SAMPLE}_sorted.bam $OUTDIR


# Index final bam, will produce file of format .bai, which needs to be in the same folder as the bam file for IGV viewing
samtools index $OUTDIR/${SAMPLE}_sorted.bam
samtools flagstat $OUTDIR/${SAMPLE}_sorted.bam > $OUTDIR/${SAMPLE}.bam.stats



