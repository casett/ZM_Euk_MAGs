#!/bin/bash -l
#
#SBATCH --ntasks 8 #number cores
#SBATCH -J sg_chytrid_drepeuk
#SBATCH --mem=50G #memory
#SBATCH -p batch
#SBATCH -o logs/12_drep_euk_combo.log
#SBATCH -e logs/12_drep_euk_combo.log


source activate anvio-7.1

BINFOLDER=euk_bin_assessment
OUT=combo_drep_euk_with_eukcc
CPU=8
EUKCC=combo_eukcc_results_for_drep.csv

dRep dereplicate -p $CPU --genomeInfo $EUKCC --completeness 1 $OUT -g $BINFOLDER/*.fa
