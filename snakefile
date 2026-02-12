# Define our directory
work_dir = '/data/catchingba/VSCode_class'

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
        ith_slice = '9'
    output:
        special_codon = work_dir+'/data/codon_list.txt',
        amino_acid_file = work_dir+'/data/amino_acid.txt'
    singularity:
        'envs/my_first_singularity.sif'
    script:
        work_dir+'/scripts/return_codon.py'