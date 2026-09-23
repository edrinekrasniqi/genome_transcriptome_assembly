#!/usr/bin/env bash

#SBATCH --job-name=kmer_count
#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --partition=pibu_el8
#SBATCH --mail-user=edrine.krasniqi@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/ekrasniqi/assembly_annotation_course/logs/kmer_%j.out
#SBATCH --error=/data/users/ekrasniqi/assembly_annotation_course/logs/kmer_%j.err

# Load Jellyfish
module load Jellyfish/2.3.0-GCC-10.3.0

# Directories
WORKDIR=/data/users/ekrasniqi/assembly_annotation_course
INPUT=$WORKDIR/Est-0/ERR11437308.fastq.gz
OUTPUT=$WORKDIR/results/kmer

mkdir -p $OUTPUT

# Count canonical 21-mers
jellyfish count \
    -C \
    -m 21 \
    -s 5G \
    -t $SLURM_CPUS_PER_TASK \
    <(zcat $INPUT) \
    -o $OUTPUT/reads.jf

# Create k-mer histogram
jellyfish histo \
    -t $SLURM_CPUS_PER_TASK \
    $OUTPUT/reads.jf \
    > $OUTPUT/reads.histo
