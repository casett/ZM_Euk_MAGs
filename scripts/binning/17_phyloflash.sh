#!/bin/bash -l
#SBATCH -p intel
#SBATCH --mem 98G
#SBATCH -n 16
#SBATCH --out logs/17_phyloflash.log
#SBATCH -J sgchyt_phyloflash
#SBATCH -t 72:00:00 #time in hours:min:sec

module load phyloFlash/3.4

CPU=16


#wget https://zenodo.org/record/7892522/files/138.1.tar.gz # 5.5 GB download
#tar -xzf 138.1.tar.gz


IN=data/filt_seqs
OUT=phyloflash
SAMP=$IN/samples_nh.csv

for prefix in `cat $SAMP`;
do
	echo $prefix
	read1=( ${prefix}.ZM_removed_R1.fastq.gz ) #the parentheses assign the globbed filename to an array (of length 1)
	read2=( ${prefix}.ZM_removed_R2.fastq.gz )

	phyloFlash.pl -lib $prefix -almosteverything -CPUs $CPU -readlength 150 -read1 $IN/${read1} -read2 $IN/${read2} -dbhome 138.1

done
