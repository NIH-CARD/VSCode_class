rule fastqc:
    input:
        input_dir = '/data/catchingba/VSCode_class/data/fastq'
    output:
        output_dir = '/data/catchingba/VSCode_class/data/fastqc'
    shell:
        """
        module load fastqc
        fastqc --output={input.input_dir} {output.output_dir}
        """