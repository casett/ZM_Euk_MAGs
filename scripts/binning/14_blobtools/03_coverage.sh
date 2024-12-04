#!/bin/bash
##
#SBATCH -p intel
#SBATCH -o logs/03_cov.log
#SBATCH -e logs/03_cov.log
#SBATCH --nodes=1
#SBATCH --ntasks=24 # Number of cores
#SBATCH --mem=64G # Memory pool 
#SBATCH -J Blob_coverage
#SBATCH --time 48:00:00

#module load bwa
module load samtools
#module load bedtools
module load minimap2

#change to your options
ASMDIR=combo_drep_euk_with_eukcc/drep_over_30
CPU=24
COV=coverage
TAXFOLDER=taxonomy
OUTPUT=blobtools
READDIR=data/filt_seqs

SAMPFILE=$OUTPUT/samples_reads.csv
#csv file with PREFIX and then the assembly names if you have multiple assemblies
#and also the prefix for the FWD and REV read sets


IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read PREFIX FWD REV
do
	
	ASSEMBLY=${ASMDIR}/$PREFIX.fa
	
	#bwa index $ASSEMBLY
	

	BAM=${OUTPUT}/${COV}/$PREFIX.$FWD.remap.bam
	FWD=${READDIR}/${FWD}.fastq.gz
	REV=${READDIR}/${REV}.fastq.gz
	
	#bwa mem -t $CPU $ASSEMBLY $FWD $REV | samtools sort --threads $CPU -T /scratch -O bam -o $BAM
	
	#samtools index $BAM

	minimap2 -ax sr -t $CPU $ASSEMBLY $FWD $REV | samtools sort --threads $CPU -T /scratch -O BAM -o $BAM
done
