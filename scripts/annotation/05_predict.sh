#!/bin/bash -l
#SBATCH -p batch
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --mem 50G 
#SBATCH --time=4-00:00:00
#SBATCH --output=logs/train.%a.log
#SBATCH -J sg_chytrid_predict
#SBATCH --array 1-5

export PATH="/opt/linux/centos/7.x/x86_64/pkgs/genemarkESET/4.71_lic:$PATH"

module load workspace/scratch
module load funannotate/1.8


CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
    CPU=$SLURM_CPUS_ON_NODE
fi

INDIR=genomes/masked
OUTDIR=annotate
PREDS=$(realpath prediction_support)
mkdir -p $OUTDIR
SAMPFILE=genomes/samples_w_busco.csv
N=${SLURM_ARRAY_TASK_ID}

if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "need to provide a number by --array or cmdline"
        exit
    fi
fi
MAX=`wc -l $SAMPFILE | awk '{print $1}'`

if [ $N -gt $MAX ]; then
    echo "$N is too big, only $MAX lines in $SAMPFILE"
    exit
fi

#export SINGULARITY_BINDPATH=/bigdata,/bigdata/operations/pkgadmin/opt/linux:/opt/linux
export AUGUSTUS_CONFIG_PATH=$(realpath lib/augustus/3.3/config)

export FUNANNOTATE_DB=/bigdata/stajichlab/shared/lib/funannotate_db

# make genemark key link required to run it
if [ ! -s ~/.gm_key ]; then
	module  load    genemarkESET/4.71_lic
	GMFOLDER=`dirname $(which gmhmme3)`
  ln -s $GMFOLDER/.gm_key ~/.gm_key
  module unload genemarkESET
fi
#export GENEMARK_PATH=/opt/genemark/gm_et_linux_64



SEQCENTER=UCDavis

IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read SPECIES STRAIN PHYLUM BIOPROJECT BIOSAMPLE LOCUS BUSCO SEED_SPECIES ORG SKIP
do
    BASE=$(echo -n ${SPECIES} | perl -p -e 's/\s+/_/g')
    echo "sample is $BASE"
    MASKED=$(realpath $INDIR/$BASE.masked.fasta)
    if [ ! -f $MASKED ]; then
      echo "Cannot find $BASE.masked.fasta in $INDIR - may not have been run yet"
      exit
    fi
   echo "looking for $MASKED to run"
   echo "LOCUSTAG IS '$LOCUS'"
# is this temp folder still needed?
    mkdir $BASE.predict.$$
    pushd $BASE.predict.$$
	
	
    if [[ $SKIP == "TRUE" ]]; then
           # no genemark
	       funannotate predict --cpus $CPU --keep_no_stops --SeqCenter $SEQCENTER --busco_db $BUSCO --optimize_augustus \
	           --min_training_models 25 --AUGUSTUS_CONFIG_PATH $AUGUSTUS_CONFIG_PATH \
	           -i ../$INDIR/$BASE.masked.fasta --name $LOCUS  --weights genemark:0 codingquarry:0 \
	           -s "$SPECIES"  -o ../$OUTDIR/$BASE --busco_seed_species $SEED_SPECIES --organism $ORG --force

	 else
    	 funannotate predict --cpus $CPU --keep_no_stops --SeqCenter $SEQCENTER --busco_db $BUSCO --optimize_augustus \
        --min_training_models 25 --AUGUSTUS_CONFIG_PATH $AUGUSTUS_CONFIG_PATH \
        -i ../$INDIR/$BASE.masked.fasta --name $LOCUS  --weights codingquarry:0 \
        -s "$SPECIES"  -o ../$OUTDIR/$BASE --busco_seed_species $SEED_SPECIES --organism $ORG --force
   	  
	fi
 	popd
 	rmdir $BASE.predict.$$
done
