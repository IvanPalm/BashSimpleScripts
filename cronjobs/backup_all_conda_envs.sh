#!/bin/sh
#date (dd.mm.yyyy) 08.02.2022
#update 05.05.2024
#author Ivan Palmegiani
#purpose Clones all conda environments in system to yml to a directory in home named condaenvs_[DateOfTheClone]


TODAY=$(date "+%Y-%m-%d")
BACKUP_DIR="/home/ivan/condaenvs-$TODAY"

CONDA_BASE=$(conda info --base)
CONDA_FUNCTION="etc/profile.d/conda.sh"
CONDA="$CONDA_BASE/$CONDA_FUNCTION"
. $CONDA

if [ ! -d $BACKUP_DIR ]; then
  mkdir $BACKUP_DIR
  echo "Creating directory $BACKUP_DIR"
else
  echo "Directory $BACKUP_DIR already exists"
fi

for env in $(conda env list | grep -v '#' | awk '{print $1}')
do
        conda env export -n $env > $BACKUP_DIR/${env}.yml
        echo "Exporting $env!"
done

# NOW=$(date +"%Y-%m-%d %H:%M:%S")
# echo -e Backed up all Conda envs on ${NOW} >> $HOME/cron_reports.txt
