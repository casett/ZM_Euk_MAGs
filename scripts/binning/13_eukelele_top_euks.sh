#!/bin/bash -l
#
#SBATCH --ntasks 8 #number cores
#SBATCH -J sg_eukelele
#SBATCH --mem=150G #memory
#SBATCH -p intel
#SBATCH -o logs/13_eukelele.log
#SBATCH -e logs/13_eukelele.log


#get proteins quickly
conda activate anvio-7.1

NTBINS=combo_drep_euk_with_eukcc/drep_over_30

cd $NTBINS
for f in *.fa;
do prodigal -i $f -o $f'_genes' -a $f'_proteins'.faa;
done

cd ..
mkdir drep_over_30_prot
mv drep_over_30/*.faa drep_over_30_prot

cd ..

conda deactivate

#EUKulele
conda activate EUKulele

BINFOLDER=combo_drep_euk_with_eukcc/drep_over_30_prot
#BINFOLDER contain proteins in .faa for each mag

EUKulele --sample_dir $BINFOLDER -m mags
