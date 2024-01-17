#!/bin/sh
#date (dd.mm.yyyy) 08.02.2022
#update 12.11.2022
#author Ivan Palmegiani
#purpose Clones all conda environments in system to yml to a directory in home named condaenvs_[DateOfTheClone]


TODAY=$(date "+%Y-%m-%d")
CONDA_BASE=$(conda info --base)
CONDA_FUNCTION="etc/profile.d/conda.sh"
CONDA="$CONDA_BASE/$CONDA_FUNCTION"
source $CONDA

mkdir ~/condaenvs-$TODAY

ENVS=$(conda env list | grep '^\w' | cut -d' ' -f1)
for env in $ENVS; do
    conda activate $env
    conda env export > $HOME/condaenvs-$TODAY/$env.yml
    echo "Exporting $env"
done

# Add line to cron report file
NOW=$(date +"%Y-%m-%d %H:%M:%S")
echo -e Backed up all Conda envs on ${NOW} >> $HOME/cron_reports.txt
