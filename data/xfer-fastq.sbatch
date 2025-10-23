#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=02:00:00
#SBATCH --job-name=xfer-fastq-array
#SBATCH --partition=short-cpu
#SBATCH --output=slurmlogs/%x.%A_%a.log # like: jobname-job.ID_1.log
datetime=$(date +"%Y-%m-%d_%H:%M:%S")
echo "[$datetime] $SLURM_JOB_NAME $@" # log the command line
echo "SLURM_JOBID=$SLURM_JOBID"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"

mkdir -p $HOME/tmp
export TMP=$HOME/tmp
export TMPDIR=$TMP

i=1
array_arg=""
while read -a line
do
    if [ $i -eq $SLURM_ARRAY_TASK_ID ]
    then
        array_arg=${line[1]}
        break
    fi

    i=$((i+1))
done < md5sum.txt

##### run script with the resolved array ID to argument
echo "array_arg=$array_arg"
cmd="scp aidlng:ebel_project/viral_tag_problem/data/$array_arg ."
echo $cmd
time eval $cmd

gunzip --keep $array_arg 
