#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --job-name=split
#SBATCH --partition=short-cpu
#SBATCH --output=slurmlogs/%x.%j.log # gives jobname.ID.log
set -ue
set -o pipefail
datetime=$(date +"%Y-%m-%d_%H:%M:%S")
echo "[$datetime] $SLURM_JOB_NAME $@" # log the command line

# use like:
# for f in wnv*R1*; do sbatch split.sh ${f%_S*} 5; done
root=$1
howmany=$2

dirname=${root}_split
prefix=${dirname}/${root}_split_

if [ -d $dirname ]
then
    echo "Already did $root => $dirname"
    #exit 0
fi


mkdir -vp $dirname

for R in R2; #R1 R2;
do
    cmd="time split -d -n $howmany ${root}*_${R}_*.fastq $prefix --additional-suffix=.$R.fastq"
    echo $cmd
    time eval $cmd
done
