#!/bin/bash -l
##
#SBATCH -o logs/02_busco_prot.log
#SBATCH -e logs/02_busco_prot.log
#SBATCH --ntasks=8 # Number of cores
#SBATCH --mem=48G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -J sg_chytrid_cg_buscoB


conda activate busco5

export AUGUSTUS_CONFIG_PATH="/bigdata/software/augustus_3.3.3/config/"

OUT=busco_results_finaldata
INDIR=finaldata

mkdir $OUT

BUSCO_SET=eukaryota_odb10

busco -i $INDIR -l $BUSCO_SET -o $OUT/busco_euk -m protein --cpu 12 

BUSCO_SET=fungi_odb10

busco -i $INDIR  -l $BUSCO_SET -o  $OUT/busco_fun -m protein --cpu 12 


