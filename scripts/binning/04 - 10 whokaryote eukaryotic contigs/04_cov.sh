#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH -e logs/W_04_cov.log
#SBATCH -o logs/W_04_cov.log
#SBATCH -J sgmag_cov_anvio

#SBATCH --mem=148G #memory
#SBATCH -p batch


module load miniconda3

source activate anvio-7

COVDIR=coverage_who
CPU=16
DIR=data/filt_seqs
SAMPFILE=$DIR/samples.csv
PREFIX=SG_Chytid_WHO
ASSEMDIR=SG_Chytid_whokartyote_results_min1000_11182021

mkdir $COVDIR
 
bowtie2-build $ASSEMDIR/contigs1000.euks.fasta ${COVDIR}/$PREFIX


IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read SAMPLE
do 
	bowtie2 --threads $CPU -x  ${COVDIR}/$PREFIX -1 ${DIR}/$SAMPLE.ZM_removed_R1.fastq.gz -2 ${DIR}/$SAMPLE.ZM_removed_R2.fastq.gz -S ${COVDIR}/$SAMPLE'.sam'
	samtools view -F 4 -bS ${COVDIR}/$SAMPLE'.sam' > ${COVDIR}/$SAMPLE'-RAW.bam'
	anvi-init-bam ${COVDIR}/$SAMPLE'-RAW.bam' -o ${COVDIR}/$SAMPLE'.bam'

done

anvi-gen-contigs-database -f $ASSEMDIR/contigs1000.euks.fasta -o $PREFIX.db
anvi-run-hmms -c $PREFIX.db --num-threads $CPU
anvi-get-sequences-for-gene-calls -c $PREFIX.db -o $PREFIX.gene.calls.fa
anvi-get-sequences-for-gene-calls -c $PREFIX.db --get-aa-sequences -o $PREFIX.amino.acid.sequences.fa


