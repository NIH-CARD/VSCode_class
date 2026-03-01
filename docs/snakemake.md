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

## Add a python script

## Rule `all`