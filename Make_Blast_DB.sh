#author Ioana Onut Brännström & Megan Sorensen


module load bioinfo-tools
module load blast/2.10.1+

GenomeFasta=$1


# no TAXID
makeblastdb -in $GenomeFasta -dbtype nucl -parse_seqids
