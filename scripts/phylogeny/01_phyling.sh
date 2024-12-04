#!/usr/bin/bash -l
#SBATCH --ntasks 24 --mem 16G --time 48:00:00 -p intel -N 1 --out logs/phyling.%A.log
#SBATCH -J sgchyt_Phyling_fungi

module load miniconda3
module load hmmer/3
module load parallel
module load muscle

#DIR=HMM
#MARKER=fungi_odb10
#URL=https://busco-data.ezlab.org/v4/data/lineages/fungi_odb10.2020-09-10.tar.gz

#if [ ! -d $DIR/$MARKER ]; then
#    mkdir -p $DIR/$MARKER
#    curl -C - -O $URL
#    FILE=$(basename $URL)
#    tar zxf $FILE
#
#    mv $MARKER/scores_cutoff $MARKER/lengths_cutoff $DIR/$MARKER
#    mv $MARKER/hmms $DIR/$MARKER/HMM3
#    cat $DIR/$MARKER/HMM3/*.hmm > $DIR/$MARKER/markers_3.hmm
#    hmmconvert -b $DIR/$MARKER/markers_3.hmm > $DIR/$MARKER/markers_3.hmmb
#
#    rm -rf fungi_odb10.2020-09-10.tar.gz $MARKER
#fi


source config.txt

./PHYling_unified/PHYling init
./PHYling_unified/PHYling search -q parallel
./PHYling_unified/PHYling aln -c -q parallel