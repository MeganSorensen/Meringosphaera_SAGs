#author Ioana Onut Brännström & Megan Sorensen


module load bioinfo-tools   			 # check for updates
module load prodigal/2.6.3

input_file=$1
Append=$2


prodigal -i $input_file -a Prodigal_${Append}.prot.faa -d Prodigal_${Append}.nucl.fasta -o Prodigal_${Append} -f gff -g 1 -p meta

### PARAMETERS
#prodigal [-a trans_file] [-c] [-d nuc_file] [-f output_type]
                 #[-g tr_table] [-h] [-i input_file] [-m] [-n] [-o output_file]
                 #[-p mode] [-q] [-s start_file] [-t training_file] [-v]

         #-a:  Write protein translations to the selected file.
         #-c:  Closed ends.  Do not allow genes to run off edges.
         #-d:  Write nucleotide sequences of genes to the selected file.
         #-f:  Select output format (gbk, gff, or sco).  Default is gbk.
         #-g:  Specify a translation table to use (default 11) - this is for bacteria! 1- is general EK
         #-h:  Print help menu and exit.
         #-i:  Specify FASTA/Genbank input file (default reads from stdin).
         #-m:  Treat runs of N as masked sequence; don't build genes across them.
         #-n:  Bypass Shine-Dalgarno trainer and force a full motif scan.
         #-o:  Specify output file (default writes to stdout).
         #-p:  Select procedure (single or meta).  Default is single.
         #-q:  Run quietly (suppress normal stderr output).
         #-s:  Write all potential genes (with scores) to the selected file.
         #-t:  Write a training file (if none exists); otherwise, read and use the specified training file.
         #-v:  Print version number and exit