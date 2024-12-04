#!/bin/bash -l
#
#SBATCH --ntasks 8 #number cores
#SBATCH -J sg_chytrid_eukCC
#SBATCH --mem=50G #memory
#SBATCH -p batch
#SBATCH -o logs/W_16_eukcc.log
#SBATCH -e logs/W_16_eukcc.log



module load miniconda3

conda activate eukcc2

export EUKCC2_DB=/rhome/cassande/bigdata/software/eukccdb/eukcc2_db_ver_1

BINFOLDER=/rhome/cassande/bigdata/eisenlab/sg_chytrid/stajichlab/WHO_anvio_profiles_1000minlen/SG_Chytid_WHO_SAMPLES_MERGED/all_bins
OUTFOLDER=/rhome/cassande/bigdata/eisenlab/sg_chytrid/stajichlab/WHO_anvio_profiles_1000minlen/SG_Chytid_WHO_SAMPLES_MERGED/eukcc_results
CPU=8

#mkdir $OUTFOLDER
#files in folder need to end in .fa
eukcc folder --out $OUTFOLDER --threads $CPU $BINFOLDER




