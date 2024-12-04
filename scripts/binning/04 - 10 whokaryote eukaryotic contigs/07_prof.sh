#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=650G #memory
#SBATCH -p highmem
#SBATCH -o logs/W_07_merge.log
#SBATCH -e logs/W_07_merge.log
#SBATCH -J sgmag_merge_anvio


COVDIR=coverage_who
CPU=16
DIR=data/filt_seqs
SAMPFILE=$DIR/samples.csv
PREFIX=SG_Chytid_WHO
ASSEMDIR=SG_Chytid_whokartyote_results_min1000_11182021
MIN=1000
PROFDIR=WHO_anvio_profiles_1000minlen


module load miniconda3
source activate anvio-7.1


anvi-merge ${PROFDIR}/*profile/PROFILE.db -o ${PROFDIR}/$PREFIX'_SAMPLES_MERGED_1000min' -c $PREFIX.db
