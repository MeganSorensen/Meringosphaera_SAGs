#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools
module load blast/2.12.0+

######################


DB=$1


makeblastdb -in $DB -dbtype prot -parse_seqids -blastdb_version 5 

