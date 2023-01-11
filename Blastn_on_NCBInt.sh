#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools
module load blast/2.10.1+ 


MyFasta=$1  #the genome file
e=1e-10 #e-value
myDB=nt
OUT=Blastn.NCBI.${MyFasta}.${e}.tab

blastn -db $myDB -query $MyFasta -max_target_seqs 100 -out $OUT -num_threads 10 -show_gis -outfmt '6 qseqid staxids bitscore std sscinames sskingdoms stitle' -culling_limit 5 -evalue $e






