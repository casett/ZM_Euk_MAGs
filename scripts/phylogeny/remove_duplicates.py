#python script to remove duplicate sequences in fasta file
#by cassie ettinger

import sys
import Bio
from Bio import SeqIO
import argparse


parser = argparse.ArgumentParser(
	prog='remove_duplicates.py',
	description='Remove duplicates from fasta file')
	
parser.add_argument('-i', '--input', help='input fasta')
parser.add_argument('-o', '--out', help='output fasta')

args = parser.parse_args()
			
def remove_dups_fasta(input_fasta, output_fasta): 
	seq_records = SeqIO.parse(input_fasta, format='fasta') #parses the fasta file
	

	seen = set()
	records = []

	for record in seq_records:  
	    if record.seq not in seen:
	        seen.add(record.seq)
	        records.append(record)
	
	SeqIO.write(records, output_fasta, "fasta")
	


remove_dups_fasta(args.input, args.out)


