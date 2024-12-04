#!/bin/bash
##
#SBATCH -p intel
#SBATCH -o logs/02_blast.log
#SBATCH -e logs/02_blast.log
#SBATCH --nodes=1
#SBATCH --ntasks=24 # Number of cores
#SBATCH --mem=64G # Memory pool 
#SBATCH -J Blob_blast


module load ncbi-blast

#db that is on cluster
DB=/srv/projects/db/NCBI/preformatted/20230321/nt


#change to your options
ASMDIR=combo_drep_euk_with_eukcc/drep_over_30
CPU=24
COV=coverage
TAXFOLDER=taxonomy
OUTPUT=blobtools
SAMPFILE=$ASMDIR/samples.csv
#csv file with PREFIX and then the assembly names if you have multiple assemblies
#and also the prefix for the FWD and REV read sets

IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read PREFIX 
do 
	ASSEMBLY=$(realpath ${ASMDIR}/$PREFIX.fa)

blastn \
 -query $ASSEMBLY \
 -db $DB \
 -outfmt "6 qseqid staxids bitscore std" \
 -max_target_seqs 10 \
 -max_hsps 1 -num_threads $CPU \
 -evalue 1e-25 -out $OUTPUT/$TAXFOLDER/$PREFIX.nt.blastn.tab


done 
