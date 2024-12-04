#!/usr/bin/bash -l
#SBATCH -p intel
#SBATCH -o logs/01_vecscreen.log
#SBATCH -e logs/01_vecscreen.log
#SBATCH --nodes=1
#SBATCH --ntasks=16 # Number of cores
#SBATCH --mem=24G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -J sgchy_vec


INPUT=genomes/filtered_bins
CPU=16
OUTPUT=genomes/vecscreen

module load AAFTF

for genome in $(ls $INPUT); 
do 
	NAME=$(basename $genome .fa)
	AAFTF vecscreen -i $INPUT/$genome -o $OUTPUT/$NAME.vecscreen.fa -c $CPU

done
