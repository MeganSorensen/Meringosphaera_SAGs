#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools
module load FastQC/0.11.5   #FastQC/0.11.5 seems to have a memory issue
module load java/sun_jdk1.8.0_151


var=""   #add the name of the folder you want to create
fastqc_dir=""  #add the directory
mkdir $fastqc_dir/$var
output="$fastqc_dir/$var"

#echo "FASTQC is in process for $var"

read1=$1
read2=$2

fastqc $read1 $read2 -o $output --threads 8


