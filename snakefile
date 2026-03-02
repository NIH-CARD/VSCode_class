# Define our directory
work_dir = '/data/catchingba/VSCode_class'

rule all:
    input:
        all_codons = work_dir+'/data/codon_list_all.txt'

rule fastqc:
    input:
        input_dir = work_dir+'/data/fastq'
    output:
        output_dir = work_dir+'/data/fastqc'
    shell:
        """
        module load fastqc
        fastqc --output={output.output_dir} {input.input_dir}
        """

rule return_codon:
    params:
        nucs = ['A', 'T', 'C', 'G'],
        i = lambda wildcards, output: output[0].split("_")[-2]
    output:
        special_codon = work_dir+'/data/codon_list_{i}_slice.txt',
        amino_acid_file = work_dir+'/data/amino_acid_{i}_slice.txt'
    singularity:
        'envs/my_first_singularity.sif'
    script:
        work_dir+'/scripts/return_codon.py'

rule concat_codons:
    input:
        special_codon = expand(
            work_dir+'/data/codon_list_{i}.txt',
            i = [9, 11, 13]
            )
    output:
        all_codons = work_dir+'/data/codon_list_all.txt'
    shell:
        """
        cat special_codon > all_codons
        """