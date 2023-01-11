#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools
module load TrimGalore/0.6.1
module load FastQC/0.11.8
module load java/sun_jdk1.8.0_151
module load cutadapt/2.3


read1=$1
read2=$2

#parameters set for illumina adapter and quality trimming		
trim_galore --nextseq 20 --phred33 --illumina --fastqc --gzip --paired --core 8 $read1 $read2  	

