#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH -J caulp_anvio_merge
#SBATCH --mem=98G #memory
#SBATCH -p batch
#SBATCH -o logs/W_08b_metabat.log
#SBATCH -e logs/W_08b_metabat.log
#SBATCH -J sgmag_metabat

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


anvi-cluster-contigs -p ${PROFDIR}/$PREFIX'_SAMPLES_MERGED_1000min'/PROFILE.db -c $PREFIX.db -C METABAT --driver metabat2 -T $CPU --just-do-it

