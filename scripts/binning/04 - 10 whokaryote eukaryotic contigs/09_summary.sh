#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=98G #memory
#SBATCH -p batch
#SBATCH -o logs/W_10_summary.log
#SBATCH -e logs/W_10_summary.log
#SBATCH -J sgmag_summary

CPU=24
MIN=1000
COVDIR=coverage_who
DIR=data/filt_seqs
SAMPFILE=$DIR/samples.csv
PREFIX=SG_Chytid_WHO
ASSEMDIR=SG_Chytid_whokartyote_results_min1000_11182021
PROFDIR=WHO_anvio_profiles_1000minlen


module load miniconda3
source activate anvio-7.1


anvi-summarize -p ${PROFDIR}/$PREFIX'_SAMPLES_MERGED_1000min'/PROFILE.db -c $PREFIX.db -o ${PROFDIR}/$PREFIX'_SAMPLES_MERGED'/sample_summary_DASTOOL -C MAXBIN

anvi-summarize -p ${PROFDIR}/$PREFIX'_SAMPLES_MERGED_1000min'/PROFILE.db -c $PREFIX.db -o ${PROFDIR}/$PREFIX'_SAMPLES_MERGED'/sample_summary_METABAT -C METABAT

anvi-summarize -p ${PROFDIR}/$PREFIX'_SAMPLES_MERGED_1000min'/PROFILE.db -c $PREFIX.db -o ${PROFDIR}/$PREFIX'_SAMPLES_MERGED'/sample_summary_CONCOCT -C CONCOCT

