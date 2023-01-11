#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools
module load blast/2.10.1+

MyFasta=$1
my_DB=$2 
append=$3
e=1e-5

#### 1. blastp on local DB
function apply_blastn {
	IN1=$MyFasta
	IN2=$my_DB 
	IN3=$append
	blastn -db $IN2 -query $IN1 -num_threads 1  -max_target_seqs 100 -evalue $e -outfmt 6 -out Blastn.${IN1}-vs-${IN3}_${e}.tab

}

apply_blastn $IN1 $IN2 $IN3
OUT1=Blastn.${IN1}-vs-${IN3}_${e}.tab



#### 2. extract the subject id if the hits 
function extract_sseqid {
	hits_IDs=$OUT1
	awk '{ print $2 }' $hits_IDs  > NamesHits.${IN3}.txt
	
}

extract_sseqid $hits_IDs 
OUT2=NamesHits.${IN3}.txt

#### 3. extract fasta based on the hits IDs
 function extract_fasta {
     list=$OUT2
     IN1=$MyFasta
	 IN3=$append
	 blastdbcmd -db $my_DB -dbtype nucl -entry_batch $list -outfmt %f -out ${IN1}-vs-${IN3}.nucl
 }

extract_fasta $list $IN1 $IN3




