#!/bin/bash -l
##
#SBATCH -o logs/15_busco_euk.log
#SBATCH -e logs/15_busco_euk.log
#SBATCH --nodes=1
#SBATCH --ntasks=12 # Number of cores
#SBATCH --mem=60G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --time=48:00:00
#SBATCH -J sg_chytid_busco




conda activate busco5


export AUGUSTUS_CONFIG_PATH="/bigdata/software/augustus_3.3.3/config/"


OUT=busco_protein
INDIR=funannotate_proteins

BUSCO_SET=eukaryota_odb10

busco -i $INDIR -l $BUSCO_SET -o $OUT/busco_euk -m protein --cpu 12 

BUSCO_SET=fungi_odb10

busco -i $INDIR  -l $BUSCO_SET -o  $OUT/busco_fun -m protein --cpu 12 

BUSCO_SET=stramenopiles_odb10

busco -i $INDIR  -l $BUSCO_SET -o  $OUT/busco_str -m protein --cpu 12 

BUSCO_SET=alveolata_odb10

busco -i $INDIR -l $BUSCO_SET -o $OUT/busco_alv -m protein --cpu 12
