#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=250G #memory
#SBATCH -p batch
#SBATCH -o logs/W_05_kaiju.log
#SBATCH -e logs/W_05_kaiju.log
#SBATCH -J sgchyt_kaiju_anvio


DB=/rhome/cassande/bigdata/software/databases/kaiju
COVDIR=coverage_who
CPU=16
DIR=data/filt_seqs
SAMPFILE=$DIR/samples.csv
PREFIX=SG_Chytid_WHO
ASSEMDIR=SG_Chytid_whokartyote_results_min1000_11182021


module load miniconda3

source activate anvio-7.1

OUT=kaiju_output
mkdir $OUT

kaiju -z $CPU -t $DB/nodes.dmp -f $DB/kaiju_db_nr_euk.fmi -i  $PREFIX.gene.calls.fa -o ${OUT}/$PREFIX.kaiju.out -v

kaiju-addTaxonNames -t $DB/nodes.dmp -n $DB/names.dmp -i ${OUT}/$PREFIX.kaiju.out -o ${OUT}/$PREFIX.kaiju.names.out -r superkingdom,phylum,class,order,family,genus,species

anvi-import-taxonomy-for-genes -i ${OUT}/$PREFIX.kaiju.names.out -c $PREFIX.db -p kaiju --just-do-it
	


