# Meringosphaera_SAGs

# A novel kleptoplastidic symbiosis revealed in the marine centrohelid Meringosphaera with evidence of genetic integration

These scripts were used for the data analysis for the article: DOI


## Section 1: SAG assembly
1.1. Quality checks -> Fastqc.sh
1.2. Trimmed -> TrimGalore.sh 
1.3. Visualise GC vs kmers -> katprofiles.sh
    *(run katprofiles.sh before and after normalisation to compare)*
1.4. Normalised -> Run_bbnorm.sh
1.5. Assemble  -> runSpades.sh 
1.6. Check completeness and coverage -> runBWA.sh
1.7. Predict plastid genome -> run_getOrganelle.sh


## Section 2: Individual gene phylogenies
2.1. Blast searches against NCBI -> Blastn_on_NCBIint.sh
2.2. Make a local blastdb -> makeblastdb
2.3. Blast searches with the local databse ->  Blastn_and_get-fasta_localDB.v2.sh
2.4. Allign hits with MAFFT, trim TRIMAL, predict tree with IQtree -> run_Mafft_TrimAL_IQtree.sh


## Section 3: Host-encoded plastid-associated protein candidates 
3.1. Map reads to the no-plastid contigs -> runBWA.sh
3.2  Extract the mapped reads -> get_mapped.sh
3.3. Coassembly of no-plastid reads based on groupings according to SAG 18S ID -> runSpades.v2.sh
    *(SAGs were clustered on >99% 18S rDNA identity, the reads from each cluser were coassembled)*
3.4. Busco compare completeness -> Busco.sh
3.5. Predict ORFs Prodigal -> run_Prodigal.sh
3.6. Make amino acid sequences a local blastdb -> MakeDB_protein.sh
3.7. Search with blastp -> Blastp_and_get-fasta_localDB.sh
3.8. Allign protein hits with MAFFT, trim with TRIMAL, predict tree with IQtree -> run_Mafft_TRIMAL_IQtree_AA.sh
3.9. Coverage checked with BWA -> runBWA.sh
    *(resulting bam file used for IGV visualisation)*
