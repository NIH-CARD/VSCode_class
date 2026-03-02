# Snakemake

Now that you have a couple of python and bash scripts and are tracking everything on GitHub, you need a way to organize your bioinformatic pipeline. The sheer number of input and output files and complexity of which steps feed into what make reproducibility a critical challenge. Snakemake, Python, and GitHub form a powerful trinity that addresses this challenge by establishing a robust, trackable, and scalable workflow. This is just a starting point for building complex pipelines, for a more comprehensive tutorial consider following the (official Snakemake tutorial)[https://snakemake.readthedocs.io/en/stable/tutorial/basics.html].

## Create bash file to run Snakemake

There are two files you need to keep track of your pipeline; your `snakefile` which will break the steps of the pipeline into standalone "rules", and a `snakemake.sh` bash script which sets up the environment for running Snakemake. The upside is that you will only need to run `bash snakemake.sh` and Snakemake will figure which scripts to run, which inputs and outputs to generate, and what resources to use for each step. Inside this bash script:
1. Load the modules Snakemake and Singularity
2. Download your premade reproducible Singularity environments
3. (on Biowulf) make sure snakemake commands can be read by downloading the Snakemake profile from GitHub
4. Run the Snakemake file

Here is an example snakemake.sh script

```
#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time 96:00:00

module load snakemake
module load apptainer

apptainer pull --disable-cache envs/single_cell.sif oras://quay.io/adamcatchingdti/single_cell_cpu:latest

# Clone github Snakemake profile
git clone https://github.com/NIH-HPC/snakemake_profile.git

# Load singularity
module load singularity

# Run snakemake
snakemake --profile snakemake_profile
```

## Start a new `snakefile`

Creating a pipeline can seem daunting when looking at completed pipelines as an example. But they all start with the first rule, which takes the raw data and performa the first step. For sequence data this can be converting raw bcls or squiggles into fastqs, or for simulations setting up the system. 

Fundamentally, each rule is a step that take an input file somewhere, reads it in, processes it, and returns an output file: 

```
rule example_rule:
    input:
        input_file_1 = "path/to/some/file",
        input_file_2 = "path/to/some/other_file"
    output:
        output_file_1 = "output/file/path"
    shell:
        'program_name --input {input.input_file_1} --output {output.output_file_1}'
```

Given a program called `program_name` that has been previously installed, the input path is piped via `input.input_file_1` and computes `output.output_file_1`. In the `snakrmake.sh` script the last line will then read:

```
snakemake -np output_file_1
```

Running the bash script will subsequently run the script and be done once the results is created.

For ease and portability, it is best to have the directory you are working in explicitly defined. This is done by adding the line

`work_dir = '/path/to/project'`

Our rule then looks like:

```
rule example_rule:
    input:
        input_file_1 = work_dir+"/file",
        input_file_2 = work_dir+"/other_file"
    output:
        output_file_1 = work_dir+"/output_file"
    shell:
        'program_name --input {input.input_file_1} --output {output.output_file_1}'
```

## Add a python script

As we played around in the [python session](python_intro.md), we can turn quick Python lines of code into stand-alone scripts. In this case we use the `return_codon.py` script. We define the rule as `return_codon` which gives two text files of outputs (Snakemake rules must read in and read out files).

```
rule return_codon:
    params:
        nucs = ['A', 'T', 'C', 'G'],
        i = 9
    output:
        special_codon = work_dir+'/data/codon_list.txt',
        amino_acid_file = work_dir+'/data/amino_acid.txt'
    singularity:
        'envs/my_first_singularity.sif'
    script:
        work_dir+'/scripts/return_codon.py'
```

File names and parameters are read in via Snakemake to the script as:

```
from Bio import Seq

# Define nucleotides
nucs = snakemake.params.nucs

codon_list = []
for first_nuc in nucs:
    for second_nuc in nucs:
        for third_nuc in nucs:
            codon_list.append(first_nuc + second_nuc + third_nuc)

# Define the location of the slice
ith_slice = int(snakemake.params.i)

with open(snakemake.output.special_codon, 'w') as f:
    f.write(codon_list[i])
    f.write('\n')
    f.close()

with open(snakemake.output.amino_acid_file, 'w') as f:
    f.write(Seq.Seq(codon_list[i]).translate())
    f.close()
```

This is why we name our input and output files, so `snakemake.input` can differentiate between different files. Parameters can be read in as lists or strings, but should not be used in place of input and output files. Again, Snakemake requires the presence of each file to know which scripts to run.

## Rule `all`

We could make sure this last script runs by adding `snakemake -np data/amino_acid.txt` to `snakemake.sh`. Or, for simplicity, we can use the special rule `all`.

The input of the `all` rule will always be created when run by Snakemake. This can be useful when multiple outputs are required, or a single rule ran many times. If we wanted the output of both rules we would add:

```
rule all:
    input:
        amino_acid_file = work_dir+'/data/amino_acid.txt',
        output_file_1 = work_dir+"/output_file"
```

This adds simplicity as the working directory doesn't need to be added outside of the `snakefile`.

## Wildcards

Wildcards propagate a parameter through multiple rules until the final rule is satisfied. Instead of writing the rule each time we need, we can make use of wildcards.

Suppose we don't want to just find the 9th codon, but for some reason we want the 9th, 11th, and 13th. First we can make the name of the output file reflects which codon is being sliced out:

```
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
```

