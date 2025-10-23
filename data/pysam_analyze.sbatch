#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --job-name=pysam-analyze
#SBATCH --partition=short-cpu
#SBATCH --output=slurmlogs/%x.%A_%a.log # like: jobname-job.ID_1.log
# Available partitions
# day-long-cpu
# day-long-gpu
# day-long-highmem
# exp-gpu
# short-cpu*
# short-gpu
# short-highmem
# week-long-cpu
# week-long-gpu
# week-long-highmem
datetime=$(date +"%Y-%m-%d_%H:%M:%S")
echo "[$datetime] $SLURM_JOB_NAME $@" # log the command line
echo "SLURM_JOBID=$SLURM_JOBID"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"

mkdir -p $HOME/tmp
export TMP=$HOME/tmp
export TMPDIR=$TMP

# load a conda environment 
cmd="source /nfs/home/dking/miniconda3/bin/activate ebel"
echo $cmd
eval $cmd

array_arg=${SLURM_ARRAY_TASK_ID:-3}
# resolve something like: wnv_mg4_S2_L001_R1_001.fastq
R1=wnv_mg${array_arg}_S?_L00?_R1_001.fastq
R2=wnv_mg${array_arg}_S?_L00?_R2_001.fastq
root=${R1%%_S*}

out=$root.tsv

##### run script with the resolved array ID to argument
echo "array_arg=$array_arg"
cmd="python pysam_analyze.py $R1 $R2 > $out"
echo $cmd
time eval $cmd

