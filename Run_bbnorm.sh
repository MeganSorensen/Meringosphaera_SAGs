#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools 
module load bbmap/38.08

IN1= 	#path for the forward fastaq file
IN2= 	#path for the reverse fastaq file
OUTDIR=		#path for the output directory
Append=		#change the name
MIN=5				# Minimum coverage kept
TARGET=100			# Target average coverage

# Make temp dir for mapping
MAPDIR_temp=$SNIC_TMP/bbnorm
mkdir $MAPDIR_temp
cd $MAPDIR_temp
cp $IN1 .
cp $IN2 .

# To normalize read coverage:
#bbnorm.sh in=reads.fq out=normalized.fq target=50 min=5
		#This will run 2-pass normalization to produce an output file of reads with an average depth of 50x. 
		#Reads with an apparent depth of under ?x (the value of MIN) will be presumed to be errors and discarded.

bbnorm.sh in=$IN1 in2=$IN2  out=$MAPDIR_temp/${Append}_R1.norm${TARGET}.fastq.gz out2=$MAPDIR_temp/${Append}_R2.norm${TARGET}.fastq.gz target=$TARGET min=$MIN k=27 threads=10 qout=auto -Xmx58g


# qout=auto           ASCII offset for output quality.  May be 33 (Sanger), 64 (Illumina), or auto (same as input).
# k=31                Kmer length (values under 32 are most efficient, but arbitrarily high values are supported)
#-Xmx                This will be passed to Java to set memory usage, overriding the program's automatic memory detection.
                    #-Xmx20g will specify 20 gigs of RAM, and -Xmx200m will specify 200 megs.  
                    #The max is typically 85% of physical memory.
                    
# To generate a kmer-frequency histogram:
#bbnorm.sh in=reads.fq khist=khist.txt peaks=peaks.txt passes=1 prefilter minprob=0 minqual=0 mindepth=0


# Sync to output directory
rsync -av $MAPDIR_temp/${Append}_R1.norm${TARGET}.fastq.gz $OUTDIR
rsync -av $MAPDIR_temp/${Append}_R2.norm${TARGET}.fastq.gz $OUTDIR
