#!/usr/bin/env bash
#SBATCH --job-name="FastQC"
#SBATCH --output=/data/users/ekrasniqi/assembly_annotation_course/results/fast_qc/qc_%j.out
#SBATCH --error=/data/users/ekrasniqi/assembly_annotation_course/logs/fast_qc/qc_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=4
#SBATCH --partition=pshort_el8
#SBATCH --mail-user=edrine.krasniqi@students.unibe.ch
#SBATCH --mail-type=end

#alternate partion used for process as pibu_el8 was overloaded.

#INPUT VARIABLE
#Sample_Directory = "${1:-Anz-0}"

#Set paths
CONTAINER="/containers/apptainer/fastqc-0.12.1.sif"
INPUT_DIR="/data/users/ekrasniqi/assembly_annotation_course/Est-0"
OUTPUT_DIR="/data/users/ekrasniqi/assembly_annotation_course/results/fast_qc"


#Run FastQC using Apptainer Container
apptainer exec --bind /data ${CONTAINER} fastqc ${INPUT_DIR}/*.fastq.gz \
    -o ${OUTPUT_DIR} \
    -t $SLURM_CPUS_PER_TASK

echo "Task complete!"
