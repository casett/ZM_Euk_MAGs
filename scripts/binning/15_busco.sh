#!/bin/bash -l
##
#SBATCH -o logs/16_busco_euk.log
#SBATCH -e logs/16_busco_euk.log
#SBATCH --nodes=1
#SBATCH --ntasks=12 # Number of cores
#SBATCH --mem=60G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --time=48:00:00
#SBATCH -J sg_chytid_busco



conda activate busco5


export AUGUSTUS_CONFIG_PATH="/bigdata/software/augustus_3.3.3/config/"


OUT=filt_top_euk_bins
INDIR=filt_top_euk_bins/filtered_bins 

BUSCO_SET=eukaryota_odb10

busco -i $INDIR -l $BUSCO_SET -o $OUT/busco_euk -m genome --cpu 12 

BUSCO_SET=fungi_odb10

busco -i $INDIR  -l $BUSCO_SET -o  $OUT/busco_fun -m genome --cpu 12 

BUSCO_SET=stramenopiles_odb10

busco -i $INDIR  -l $BUSCO_SET -o  $OUT/busco_str -m genome --cpu 12 

BUSCO_SET=alveolata_odb10

busco -i $INDIR -l $BUSCO_SET -o $OUT/busco_alv -m genome --cpu 12
