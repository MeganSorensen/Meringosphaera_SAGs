#author Ioana Onut Brännström & Megan Sorensen

module load bioinfo-tools            
module load BUSCO/5.3.1 
module load  augustus/3.4.0 
 


ASSEMBLY=$1


##### run Busco with eukaryota_odb10
source $AUGUSTUS_CONFIG_COPY
function apply_BUSCO {
    my_assembly=$ASSEMBLY   #The my_assembly is the first parameter to this function
    LINEAGE=$BUSCO_LINEAGE_SETS/eukaryota_odb10
    run_BUSCO.py -i $my_assembly -l $LINEAGE -c 4 -m genome -o BUSCOeuk
}
apply_BUSCO $my_assembly


