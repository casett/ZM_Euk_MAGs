#!/bin/bash -l
##
#SBATCH -p batch
#SBATCH -o logs/04_create.log
#SBATCH -e logs/04_create.log
#SBATCH --nodes=1
#SBATCH --ntasks=16 # Number of cores
#SBATCH --mem=32G # Memory pool
#SBATCH -J Blob_create
#SBATCH --time 48:00:00

module load db-ncbi
module load db-uniprot

#local conda install - use module load instead for HPCC
source activate btk_env

#local install to my bigdata for the sourcecode
#export PATH=$PATH:/rhome/cassande/bigdata/software/blobtoolkit/blobtools2



#change to your options
ASMDIR=combo_drep_euk_with_eukcc/drep_over_30
CPU=16
COV=coverage
TAXFOLDER=taxonomy
OUTPUT=blobtools
READDIR=data/filt_seqs

#SAMPFILE=$OUTPUT/samples.csv
SAMPFILE=$ASMDIR/samples.csv

#csv file with PREFIX and then the assembly names if you have multiple assemblies
#and also the prefix for the FWD and REV read sets

TAXDUMP=/srv/projects/db/blobPlotDB/taxonomy/

FWD1=CE_108A_S70_R1_filtered
FWD2=CE_109A_S71_R1_filtered
FWD3=CE_140A_S72_R1_filtered

IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read PREFIX 
do
	
	ASSEMBLY=${ASMDIR}/$PREFIX.fa
	BAM1=${OUTPUT}/${COV}/$PREFIX.$FWD1.remap.bam
	BAM2=${OUTPUT}/${COV}/$PREFIX.$FWD2.remap.bam
	BAM3=${OUTPUT}/${COV}/$PREFIX.$FWD3.remap.bam

	PROTTAX=${OUTPUT}/${TAXFOLDER}/$PREFIX.diamond.tab
	BLASTTAX=${OUTPUT}/${TAXFOLDER}/$PREFIX.nt.blastn.tab
	
	#create blob
	blobtools create --fasta $ASSEMBLY --replace ${OUTPUT}/$PREFIX 

	blobtools add --cov $BAM1 --cov $BAM2 --cov $BAM3 --threads 16 --replace ${OUTPUT}/$PREFIX

	blobtools add --hits $PROTTAX --hits $BLASTTAX --taxrule bestsumorder --taxdump $TAXDUMP --replace ${OUTPUT}/$PREFIX
	
	#if you have BUSCO results you can import the full_summary.tsv for them into blobtools using the add command as well
	#for basic bacterial contamination removal I haven't found this useful, but can be in more complex cases
	#blobtools add --busco $PREFIX.YOURFAVEBUSCOSET.full_summary.tsv

done
