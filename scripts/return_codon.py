# This script generates a list of codons
# and returns a sliced item in this list.

from Bio import Seq

# Define nucleotides
nucs = snakemake.params.nucs

codon_list = []
for first_nuc in nucs:
    for second_nuc in nucs:
        for third_nuc in nucs:
            codon_list.append(first_nuc + second_nuc + third_nuc)

# Define the location of the slice
ith_slice = int(snakemake.params.ith_slice)

with open(snakemake.output.special_codon, 'w') as f:
    f.write(codon_list[ith_slice])
    f.write('\n')
    f.close()