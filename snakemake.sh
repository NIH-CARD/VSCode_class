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
snakemake --profile snakemake_profile --use-singularity return_codon