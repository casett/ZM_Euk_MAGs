#!/usr/bin/bash -l
#SBATCH -p intel
#SBATCH -n 8
#SBATCH --mem 96gb
#SBATCH --out logs/rmodel.log
#SBATCH -J sgchyt_repeat

module load RepeatModeler/2.0.3

SAMPFILE=genomes/samples.csv
DIR=genomes/sort

CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
    CPU=$SLURM_CPUS_ON_NODE
fi


IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read SPECIES STRAIN PHYLUM BIOPROJECT BIOSAMPLE LOCUS
do
    name=$(echo -n ${SPECIES} | perl -p -e 's/\s+/_/g')
    echo "$name"

	BuildDatabase -name repeat_library/$name ${DIR}/$name-filt-contigs.sort.fa

	# this can take 2-48 hrs depending on genome size - you may need to set job running
	RepeatModeler -database repeat_library/$name -LTRStruct -pa $CPU

done

