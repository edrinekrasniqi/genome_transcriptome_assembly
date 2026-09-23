#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=edrine.krasniqi@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/ekrasniqi/assembly_annotation_course/logs/fastp_%j.out
#SBATCH --error=/data/users/ekrasniqi/assembly_annotation_course/logs/fastp_%j.err
#SBATCH --partition=pibu_el8

# Load fastp
module load fastp/0.23.4-GCC-10.3.0

# Directories
WORKDIR=/data/users/ekrasniqi/assembly_annotation_course

RNA_DIR=$WORKDIR/RNAseq_Sha
PACBIO_DIR=$WORKDIR/Est-0

RNA_OUT=$WORKDIR/read_QC/fastp/RNAseq_Sha
PACBIO_OUT=$WORKDIR/read_QC/fastp/Est-0

mkdir -p $RNA_OUT
mkdir -p $PACBIO_OUT

# --------------------------------------------------
# Illumina RNA-seq: filter and trim reads
# --------------------------------------------------

fastp \
    -i $RNA_DIR/ERR754081_1.fastq.gz \
    -I $RNA_DIR/ERR754081_2.fastq.gz \
    -o $RNA_OUT/ERR754081_1_trimmed.fastq.gz \
    -O $RNA_OUT/ERR754081_2_trimmed.fastq.gz \
    --html $RNA_OUT/fastp_report.html \
    --json $RNA_OUT/fastp_report.json \
    --thread $SLURM_CPUS_PER_TASK

# --------------------------------------------------
# PacBio HiFi: no filtering, obtain total bases
# --------------------------------------------------

fastp \
    -i $PACBIO_DIR/ERR11437308.fastq.gz \
    -o $PACBIO_OUT/ERR11437308.fastq.gz \
    --disable_quality_filtering \
    --disable_length_filtering \
    --disable_adapter_trimming \
    --html $PACBIO_OUT/fastp_report.html \
    --json $PACBIO_OUT/fastp_report.json \
    --thread $SLURM_CPUS_PER_TASK

    