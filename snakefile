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
        fastqc --output={input.input_dir} {output.output_dir}
        """

rule return_codon:
    params:
        nucs = ['A', 'T', 'C', 'G'],
        ith_slice = '9'
    output:
        special_codon = work_dir+'/data/codon_list.txt'
    script:
        work_dir+'/scripts/return_codon.py'