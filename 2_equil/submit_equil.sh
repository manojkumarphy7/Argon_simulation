#!/bin/sh
#Set the job name (for your reference)
#PBS -N  argon 
### Set the project name, your department code by default
#PBS -P mll703.course
### Request email when job begins and ends
#PBS -m bea
### Specify email address to use for notification.
#PBS -M $USER
### chunk specific resources ###(select=5:ncpus=4:mpiprocs=4:ngpus=2:mem=2GB::centos=skylake etc.)
#PBS -l select=1:ncpus=4
### Specify "wallclock time" required for this job, hhh:mm:ss
#PBS -l walltime=00:10:00


## Keep single # before PBS to consider it as command ,
## more than one # before PBS considered as comment.
## any command/statement other than PBS starting with # is considered as comment.
## Please comment/uncomment the portion as per your requirement before submitting job

export OMP_NUM_THREADS=4

#Environment Setup
echo "==============================="
module load apps/gromacs/2021.4/gnu
echo $PBS_JOBID
cd $PBS_O_WORKDIR
PROCS=$((PBS_NTASKS / OMP_NUM_THREADS))

#job execution command

gmx_mpi grompp -f nvt.mdp -c ../1_em/em.gro -p ../initial/topol.top -o nvt.tpr -maxwarn 2
gmx_mpi mdrun -deffnm nvt -v
