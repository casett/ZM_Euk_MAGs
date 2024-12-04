#!/bin/bash -l
#SBATCH -p batch --ntasks 32 --mem 298G --out logs/orthofinder.all.log
#SBATCH -J sg_chytrid_orthofinderB


module load diamond
module load orthofinder


CPU=32

ulimit -n 262144
ulimit -Hn
ulimit -Sn


orthofinder -f finaldata -M msa -A mafft -T fasttree -o finalresults -t $CPU
#orthofinder -M msa -A mafft -T fasttree -ft results/Results_Sep06 -t $CPU
