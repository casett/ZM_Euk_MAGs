#!/usr/bin/bash
#SBATCH --ntasks 32 -N 1 --mem 298gb -p batch --out logs/iqtree.%A.log
#SBATCH -J sgchy_iqtree_fungi
#SBATCH --time=14-00:00:00

CPU=$SLURM_CPUS_ON_NODE
if [ -z $CPU ]; then
	CPU=1
fi

module load miniconda3
module load iqtree
module load extra
module load GCCcore/7.4.0
NUM=$(wc -l expected_prefixes.lst | awk '{print $1}')
source config.txt


ALN=$PREFIX.${NUM}_taxa.${HMM}.aa.fasaln
iqtree2 -s $ALN -pre ${PREFIX}.${NUM}.${HMM} -alrt 1000 -bb 1000 -m MFP -nt $CPU



