## Meringosphaera_SAGs

# A novel kleptoplastidic symbiosis revealed in the marine centrohelid Meringosphaera with evidence of genetic integration

These scripts were part of the data analysis for the article: DOI


## Section 1: SAG assembly
1. Quality checks -> a.Fastqc.sh
2. Trim adaptors -> b.TrimGalore.sh 
3. Visualise GC vs kmers -> c.Katprofiles.sh  
*(run katprofiles.sh before and after normalisation to compare, and to set target value)*
5. Normalise coverage -> d.Run_bbnorm.sh
6. Assemble reads -> e.runSpades.sh 
7. Check completeness and coverage -> f.runBWA.sh
8. Predict plastid genome -> g.run_getOrganelle.sh


## Section 2: Individual gene phylogenies
1. Blast searches against NCBI -> h.Blastn_on_NCBIint.sh
2. Make a local blastdb -> i.Make_Blast_DB.sh
3. Blast searches with the local databse ->  j.Blastn_and_get-fasta_localDB.sh
4. Allign hits with MAFFT, trim with TRIMAL, and predict tree with IQtree -> k.run_Mafft_TrimAL_IQtree.sh


## Section 3: Host-encoded plastid-associated protein candidates 
1. Map reads to the no-plastid contigs -> f.runBWA.sh
2. Extract the mapped reads -> l.get_mapped.sh
3. Coassembly of no-plastid reads based on groupings according to SAG 18S ID -> e.runSpades.sh  
   *(SAGs were clustered on >99% 18S rDNA identity, the reads from each cluser were coassembled)*
5. Busco assess completeness -> m.Busco.sh
6. Predict ORFs with Prodigal -> n.run_Prodigal.sh
7. Make predicted amino acid sequences a local blastdb -> o.MakeDB_protein.sh
8. Search with blastp -> p.Blastp_and_get-fasta_localDB.sh
9. Allign protein hits with MAFFT, trim with TRIMAL, predict tree with IQtree -> q.run_Mafft_TRIMAL_IQtree_AA.sh
10. Coverage checked with BWA -> f.runBWA.sh  
   *(resulting bam file used for IGV visualisation)*
