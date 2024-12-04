#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=650G #memory
#SBATCH -p highmem
#SBATCH -o logs/W_06_profile.log
#SBATCH -e logs/W_06_profile.log
#SBATCH -J sgmag_profile_anvio


DB=/rhome/cassande/bigdata/software/databases/kaiju
COVDIR=coverage_who
CPU=16
DIR=data/filt_seqs
SAMPFILE=$DIR/samples.csv
PREFIX=SG_Chytid_WHO
ASSEMDIR=SG_Chytid_whokartyote_results_min1000_11182021
MIN=1000
OUT=WHO_anvio_profiles_1000minlen


module load miniconda3
source activate anvio-7.1

mkdir $OUT

IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read SAMPLE
do 
	anvi-profile -i ${COVDIR}/$SAMPLE'.bam' -c $PREFIX.db --num-threads $CPU --min-contig-length $MIN --cluster-contigs --output-dir ${OUT}/$SAMPLE'_profile'
done
