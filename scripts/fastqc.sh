#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mem=32g
#SBATCH --time=3:00:00
#SBATCH --partition=quick
#SBATCH --error=/data/catchingba/VSCode/logs/fastqc_error
#SBATCH --output=/data/catchingba/VSCode/logs/fastqc_output

# Load necessary packages
module load fastqc

input_dir='/data/catchingba/data/fastq'
output_dir='/data/catchingba/data/fastqc'

mkdir -p "$output_dir"

for file in /data/catchingba/data/fastq/*.fastq; do
    fastqc --output=$output_dir $file
done