#!/bin/bash -l
#SBATCH --ntasks=16 # Number of cores
#SBATCH --mem=50G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -p intel,batch
#SBATCH -o logs/3b_who.log
#SBATCH -e logs/3b_who.log
#SBATCH -J sgmag_whokaryote


module unload miniconda2
module load miniconda3

conda activate whokaryote


INDIR=SG_Chytid_CoAssem
FASTA=SG_Chytid.fixed.fa
OUT=SG_Chytid_whokartyote_results_min1000_11182021
CPU=16
MIN=1000

#mkdir $OUT

#default minlen = 5000
whokaryote.py --contigs $INDIR/$FASTA --outdir $OUT --f --minsize $MIN
