#author Megan Sorensen 2021
  
module load bioinfo-tools          
module load GetOrganelle/1.7.3.3
module load GetOrganelleDB/0.0.1

read1=$1
read2=$2
#seed=$3 	#If using a seed supply a seed genome
OUTDIR=		#Path for the output directory

#Using the other_pt standard database
get_organelle_from_reads.py -1 $read1 -2 $read2 -t 5 -o $OUTDIR -F other_pt -R 15 -k 21,45,65,85,105 

#If using a seed genome
#get_organelle_from_reads.py -1 $read1 -2 $read2 -t 5 -o $OUTDIR -F other_pt -R 15 -k 21,45,65,85,105 -s $seed






