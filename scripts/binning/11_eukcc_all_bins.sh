#!/bin/bash -l
#
#SBATCH --ntasks 8 #number cores
#SBATCH -J sg_chytrid_eukCC
#SBATCH --mem=50G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/11_eukcc.log
#SBATCH -e logs/11_eukcc.log



module unload miniconda2
module load miniconda3

conda activate eukcc2

export EUKCC2_DB=/rhome/cassande/bigdata/software/eukccdb/eukcc2_db_ver_1

BINFOLDER=/rhome/cassande/bigdata/eisenlab/sg_chytrid/stajichlab/anvio_profiles_1000minlen/SG_Chytid_SAMPLES_MERGED/all_bins
OUTFOLDER=/rhome/cassande/bigdata/eisenlab/sg_chytrid/stajichlab/anvio_profiles_1000minlen/SG_Chytid_SAMPLES_MERGED/eukcc_results
CPU=8

#mkdir $OUTFOLDER
#files in folder need to end in .fa
eukcc folder --out $OUTFOLDER --threads $CPU $BINFOLDER



