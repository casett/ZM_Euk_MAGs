#!/usr/bin/bash -l
#SBATCH -p batch
#SBATCH -o logs/02_fun.sort.log
#SBATCH -e logs/02_fun.sort.log
#SBATCH --nodes=1
#SBATCH --ntasks=8 # Number of cores
#SBATCH --mem=24G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -J sgchy_sort




module load funannotate/1.8


INPUT=genomes/vecscreen
CPU=16
OUTPUT=genomes/sort


for genome in $(ls $INPUT); 
do 
	NAME=$(basename $genome .vecscreen.fa)
	funannotate sort -i $INPUT/$genome -o $OUTPUT/$NAME'.sort.fa'

done
