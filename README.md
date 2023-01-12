## Meringosphaera_SAGs

# A novel kleptoplastidic symbiosis revealed in the marine centrohelid Meringosphaera with evidence of genetic integration

These scripts were part of the data analysis for the article: DOI  
Many of the scripts here are based on those from a previous project (https://github.com/IoanaBrannstrom/Pcanceri_MRO) conducted by one of the co-authors


## Section 1: SAG assembly
1. Quality checks -> a.Fastqc.sh
2. Trim adaptors -> b.TrimGalore.sh 
3. Visualise GC vs kmers -> c.Katprofiles.sh  
*(run katprofiles.sh before and after normalisation to compare, and to set target value)*
4. Normalise coverage -> d.Run_bbnorm.sh
5. Assemble reads -> e.runSpades.sh 
6. Check completeness and coverage -> f.runBWA.sh
7. Predict plastid genome -> g.run_getOrganelle.sh
8. Annotate plastid genomes with Mfannot -> at https://megasun.bch.umontreal.ca/apps/mfannot/
9. Compare plastid annotations -> h.Compare_plastid_annotation.R


## Section 2: Individual gene phylogenies
1. Blast searches against NCBI -> i.Blastn_on_NCBIint.sh
2. Make a local blastdb -> j.Make_BlastDB.sh
3. Blast searches with the local databse ->  k.Blastn_and_get-fasta_localDB.sh
4. Allign hits with MAFFT, trim with TRIMAL, and predict tree with IQtree -> l.run_Mafft_TrimAL_IQtree.sh


## Section 3: Host-encoded plastid-associated protein candidates 
1. Map reads to the no-plastid contigs -> f.runBWA.sh
2. Extract the mapped reads -> m.get_mapped.sh
3. Coassembly of no-plastid reads based on groupings according to SAG 18S ID -> e.runSpades.sh  
   *(SAGs were clustered on >99% 18S rDNA identity, the reads from each cluser were coassembled)*
4. Busco assess completeness -> n.Busco.sh
5. Plot Busco completeness -> o.busco_plots.R
6. Predict ORFs with Prodigal -> p.run_Prodigal.sh
7. Make predicted amino acid sequences a local blastdb -> q.MakeDB_protein.sh
8. Search with blastp -> r.Blastp_and_get-fasta_localDB.sh
9. Allign protein hits with MAFFT, trim with TRIMAL, predict tree with IQtree -> s.run_Mafft_TRIMAL_IQtree_AA.sh
10. Coverage checked with BWA -> f.runBWA.sh  
   *(resulting bam file used for IGV visualisation)*
