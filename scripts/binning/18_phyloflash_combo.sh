#!/bin/bash -l
#SBATCH -p intel
#SBATCH --mem 98G
#SBATCH -n 16
#SBATCH --out logs/18_phyloflash.log
#SBATCH -J sgchyt_phyloflash
#SBATCH -t 72:00:00 #time in hours:min:sec

zcat data/filt_seqs/*.ZM_removed_R1.fastq.gz > data/combined_filt_seq/SGCOMBO.ZM_removed_R1.fastq
zcat data/filt_seqs/*.ZM_removed_R2.fastq.gz > data/combined_filt_seq/SGCOMBO.ZM_removed_R2.fastq


module load phyloFlash/3.4

CPU=16

#wget https://zenodo.org/record/7892522/files/138.1.tar.gz # 5.5 GB download
#tar -xzf 138.1.tar.gz

IN=data/combined_filt_seq
OUT=phyloflash_combo

phyloFlash.pl -lib SGCOMBO -almosteverything -CPUs $CPU -readlength 150 -read1 $IN/SGCOMBO.ZM_removed_R1.fastq -read2 $IN/SGCOMBO.ZM_removed_R2.fastq -dbhome 138.1


