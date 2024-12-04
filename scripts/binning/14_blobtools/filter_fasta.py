#python script to filter fasta file
#by cassie ettinger

import sys
import Bio
from Bio import SeqIO
import argparse


parser = argparse.ArgumentParser(
	prog='filter_fasta.py',
	description='Filter fasta file')
	
parser.add_argument('-i', '--input', help='input fasta')
parser.add_argument('-o', '--out', help='output fasta')
parser.add_argument('-c', '--contam', help='text file with contig ids to remove')

args = parser.parse_args()
			
def filter_fasta(input_fasta, output_fasta, remove): 
	seq_records = SeqIO.parse(input_fasta, format='fasta') #parses the fasta file
	

	with open(remove) as f:
		remove_ids_list = f.read().splitlines() #parse the contamination file which is each line as a scaffold id 
	
	OutputFile = open(output_fasta, 'w') #opens new file to write to
	
	for record in seq_records: 
		if record.id not in remove_ids_list: 
			OutputFile.write('>'+ record.id +'\n') #writes the scaffold to the file (or assession) 
			OutputFile.write(str(record.seq)+'\n') #writes the seq to the file
			
	OutputFile.close()


filter_fasta(args.input, args.out, args.contam)


