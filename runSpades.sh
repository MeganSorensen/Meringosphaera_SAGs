#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools 
module load spades/3.13.1    

READ1=$1
READ2=$2


OUTDIR=		#path for the output directory
Append=raw
TMPDIR=$SNIC_TMP/Spades_cluster2b${Append}
mkdir $TMPDIR

#### MetaSpades
#metaspades.py -t 10 -o $OUTDIR --pe1-1 $READ1 --pe1-2 $READ2 -k auto

#### normal Spades but careful
spades.py --careful -t 10 -k auto -o $TMPDIR --pe1-1 $READ1 --pe1-2 $READ2

#### single cell Spades but careful
#spades.py --sc --careful -t 10 -k auto -o $TMPDIR --pe1-1 $READ1 --pe1-2 $READ2


#rsync -av $TMPDIR/* $OUTDIR
rsync -av $TMPDIR/*.fasta $OUTDIR
rsync -av $TMPDIR/*.gfa $OUTDIR
rsync -av $TMPDIR/*.log $OUTDIR


