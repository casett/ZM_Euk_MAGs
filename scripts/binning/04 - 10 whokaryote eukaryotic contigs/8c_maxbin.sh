#!/bin/bash -l
#
#SBATCH --ntasks 32 #number cores
#SBATCH --mem=700G #memory
#SBATCH -p highmem
#SBATCH -o logs/W_08c_maxbin.log
#SBATCH -e logs/W_08c_maxbin.log
#SBATCH -J sgmag_maxbin


CPU=32
MIN=1000
COVDIR=coverage_who
DIR=data/filt_seqs
SAMPFILE=$DIR/samples.csv
PREFIX=SG_Chytid_WHO
ASSEMDIR=SG_Chytid_whokartyote_results_min1000_11182021
PROFDIR=WHO_anvio_profiles_1000minlen


module load miniconda3
source activate anvio-7.1

anvi-cluster-contigs -p ${PROFDIR}/$PREFIX'_SAMPLES_MERGED_1000min'/PROFILE.db -c $PREFIX.db -C MAXBIN --driver maxbin2 -T $CPU --just-do-it
