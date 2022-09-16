#!/bin/bash
#date 08.02.2022
#update 
#author Ivan Palmegiani
#purpose Creates a folder named condaenvs followed by todays date and clones all conda environments in system to yml in that directory 


TODAY=$(date "+%Y-%m-%d")
CONDA_BASE=$(conda info --base)
CONDA_FUNCTION="etc/profile.d/conda.sh"
CONDA="$CONDA_BASE/$CONDA_FUNCTION"
source $CONDA

mkdir ~/condaenvs-$TODAY

ENVS=$(conda env list | grep '^\w' | cut -d' ' -f1)
for env in $ENVS; do
    conda activate $env
    conda env export > ~/condaenvs-$TODAY/$env.yml
    echo "Exporting $env"
done

echo -e Backed up all Conda envs on ${TODAY} >> cron_reports.txt
