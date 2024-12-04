#!/bin/bash
##
#SBATCH -p intel
#SBATCH -o logs/01_diamond.log
#SBATCH -e logs/01_diamond.log
#SBATCH --nodes=1
#SBATCH --ntasks=24 # Number of cores
#SBATCH --mem=96G # Memory pool 
#SBATCH -J Blob_diamond



module load diamond

#db that is on cluster
DB=/srv/projects/db/blobPlotDB/2021_04/reference_proteomes.dmnd


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

	diamond blastx \
	--query $ASSEMBLY \
	--db $DB -c1 --tmpdir /scratch \
	--outfmt 6 qseqid staxids bitscore qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore\
	--max-target-seqs 1 \
	--evalue 1e-25 --threads $CPU \
	--out $OUTPUT/$TAXFOLDER/$PREFIX.diamond.tab

done

