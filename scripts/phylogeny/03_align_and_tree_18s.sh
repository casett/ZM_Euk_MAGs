#!/bin/bash -l
#SBATCH -p batch --ntasks 32 --mem 98G --out logs/01c_align_and_tree.log
#SBATCH -J LOBU_SSU_align_and_tree
#SBATCH --time=7-00:00:00

module load mafft
module load trimal
module load iqtree
module load ssu-align

CPU=32


#file=Lobul.SSU.fa

for file in $(ls SSU_select_data);
do
	PREFIX=$(basename $file .fa)
	mafft --auto SSU_select_data/$file > $PREFIX.align.mafft
	ssu-align SSU_select_data/$file $PREFIX.ssualign
	ssu-mask $PREFIX.ssualign
	ssu-mask --stk2afa $PREFIX.ssualign
	sed 's/[.]/-/g' $PREFIX.ssualign/$PREFIX.ssualign.eukarya.afa > $PREFIX.ssualign/$PREFIX.ssualign.eukarya.gapfix.afa

	trimal -in $PREFIX.ssualign/$PREFIX.ssualign.eukarya.gapfix.afa -out $PREFIX.trimmed.ssuA -gappyout
        trimal -in $PREFIX.trimmed.ssuA -out $PREFIX.trimmedmore.ssuA  -resoverlap .75 -seqoverlap 50
        iqtree2 -s $PREFIX.trimmedmore.ssuA -pre $PREFIX.ssuA -alrt 1000 -bb 1000 -m MFP -T AUTO

	trimal -in $PREFIX.align.mafft -out $PREFIX.trimmed.mafft -gappyout
	trimal -in $PREFIX.trimmed.mafft -out $PREFIX.trimmedmore.mafft  -resoverlap .75 -seqoverlap 50
	iqtree2 -s $PREFIX.trimmedmore.mafft -pre $PREFIX.mafft -alrt 1000 -bb 1000 -m MFP -T AUTO

done 
