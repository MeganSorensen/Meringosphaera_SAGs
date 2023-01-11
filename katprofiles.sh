#does illumina adapter and quality trimming		

module load bioinfo-tools   		
module load KAT/2.4.2_py3.7.2


READ1=$1
READ2=$2
OUTPUT=     #provide the output name
Append1=Hist.$OUTPUT    
Append2=GC.$OUTPUT               

# !!!! change zcat to cat if your files are not zipped


#### run KAT hist
# it will give you a histogram of the k-mers of your reads
 function apply_KAThist {
     READ1=$1 # The first read pair
     READ2=$2 # The second read pair
     COMBINED_DATAhist=combined_data-${Append1}.fastq # The file combining the read data
     mkfifo $COMBINED_DATAhist && zcat $READ1 $READ2 > $COMBINED_DATAhist & # Make a named pipe and combine reads   #if your reads are not zipped use cat instead of cat
   	 kat hist -t 10 -d -o $OUTPUT.hist $COMBINED_DATAhist
   	 kat_jellyfish dump $OUTPUT.hist-hash.jf27 > $OUTPUT.hist.lst
   	 rm -rf $COMBINED_DATAhist # Clean up
 }
 
 
apply_KAThist $READ1 $READ2


#### run KAT plot GC
# it will give you a plot of the k-mers and the GC content of your reads
 function apply_KATplotGC {
     READ1=$1 # The first read pair is the second parameter to this function
     READ2=$2 # The second read pair is the third parameter to this function
     COMBINED_DATAgc=combined_data-${Append2}.fastq # The file combining the read data
     mkfifo $COMBINED_DATAgc && zcat $READ1 $READ2 > $COMBINED_DATAgc & # Make a named pipe and combine reads   #if your reads are not zipped use cat instead of cat
   	 kat gcp -t 10 -o $OUTPUT.gcp $COMBINED_DATAgc
     rm -rf $COMBINED_DATAgc # Clean up
 }
 
apply_KATplotGC $READ1 $READ2