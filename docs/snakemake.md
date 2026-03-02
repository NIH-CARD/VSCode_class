# Snakemake

Now that you have a couple of python and bash scripts and are tracking everything on GitHub, you need a way to organize your bioinformatic pipeline. The sheer number of input and output files and complexity of which steps feed into what make reproducibility a critical challenge. Snakemake, Python, and GitHub form a powerful trinity that addresses this challenge by establishing a robust, trackable, and scalable workflow. This is just a starting point for building complex pipelines, for a more comprehensive tutorial consider following the (official Snakemake tutorial)[https://snakemake.readthedocs.io/en/stable/tutorial/basics.html].

## Create bash file to run Snakemake

There are two files you need to keep track of your pipeline; your `snakefile` which will break the steps of the pipeline into standalone "rules", and a `snakemake.sh` bash script which sets up the environment for running Snakemake. The upside is that you will only need to run `bash snakemake.sh` and Snakemake will figure which scripts to run, which inputs and outputs to generate, and what resources to use for each step. Inside this bash script:
1. Load the modules Snakemake and Singularity
2. Download your premade reproducible Singularity environments
3. (on Biowulf) make sure snakemake commands can be read by downloading the Snakemake profile from GitHub
4. Run the Snakemake file

Here is an example snakemake.sh script

(script here)

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


## Add a python script

## Rule `all`