#author Ioana Onut Brännström & Megan Sorensen


module load bioinfo-tools   			 # check for updates
module load MAFFT/7.407
module load trimAl/1.4.1
module load iqtree/1.6.5-omp-mpi
module load gcc/6.3.0 openmpi/2.1.0 

### SETTINGS
OUTDIR=	 #path to the output directory
fasta=	 #path to the fasta file
append= 	# the name you want your alignments and tree files to have

# Make temp dir
MAPDIR_temp=$SNIC_TMP/IQtrees
mkdir $MAPDIR_temp
cd $MAPDIR_temp
cp $fasta .

##### Run Mafft-auto
    mafft --auto --adjustdirectionaccurately --thread 2 --reorder $fasta > ${append}.Mafft-auto.fa
   
##### Run Trim-Al
	TRIM=${append}.Mafft-auto.fa
	trimal -in $TRIM -out ${append}.trimAl-gappy.fa -gappyout -fasta 

##### Run IQTree
	INPUT=${append}.trimAl-gappy.fa
	OUTPUT=${append}.IQtree
	iqtree -s $INPUT -m TEST -bb 1000 -alrt 1000 -st DNA -nt 2 -pre $OUTPUT

### sync the files back in the OUTDIR
rsync -av $MAPDIR_temp/${append}.Mafft-auto.fa $OUTDIR
rsync -av $MAPDIR_temp/${append}.trimAl-gappy.fa $OUTDIR
rsync -av $MAPDIR_temp/${append}.IQtree.log $OUTDIR
rsync -av $MAPDIR_temp/${append}.IQtree.treefile $OUTDIR

