# Meringosphaera_SAGs

# A novel kleptoplastidic symbiosis revealed in the marine centrohelid Meringosphaera with evidence of genetic integration

These scripts were used for the data analysis for the article: DOI


## Section 1: SAG assembly
1. Quality checks -> Fastqc.sh
2. Trimmed -> TrimGalore.sh 
3. Visualise GC vs kmers -> katprofiles.sh
   *(run katprofiles.sh before and after normalisation to compare)*
5. Normalised -> Run_bbnorm.sh
6. Assemble  -> runSpades.sh 
7. Check completeness and coverage -> runBWA.sh
8. Predict plastid genome -> run_getOrganelle.sh


## Section 2: Individual gene phylogenies
1. Blast searches against NCBI -> Blastn_on_NCBIint.sh
2. Make a local blastdb -> makeblastdb
3. Blast searches with the local databse ->  Blastn_and_get-fasta_localDB.v2.sh
4. Allign hits with MAFFT, trim TRIMAL, predict tree with IQtree -> run_Mafft_TrimAL_IQtree.sh


## Section 3: Host-encoded plastid-associated protein candidates 
1. Map reads to the no-plastid contigs -> runBWA.sh
2  Extract the mapped reads -> get_mapped.sh
3. Coassembly of no-plastid reads based on groupings according to SAG 18S ID -> runSpades.v2.sh
   *(SAGs were clustered on >99% 18S rDNA identity, the reads from each cluser were coassembled)*
5. Busco compare completeness -> Busco.sh
6. Predict ORFs Prodigal -> run_Prodigal.sh
7. Make amino acid sequences a local blastdb -> MakeDB_protein.sh
8. Search with blastp -> Blastp_and_get-fasta_localDB.sh
9. Allign protein hits with MAFFT, trim with TRIMAL, predict tree with IQtree -> run_Mafft_TRIMAL_IQtree_AA.sh
10. Coverage checked with BWA -> runBWA.sh
   *(resulting bam file used for IGV visualisation)*
