#!/bin/sh
#date (dd.mm.yyyy) 16.09.2022
#update 05.05.2024
#author Ivan Palmegiani
#purpose Update all extensions in VC Code 


for ext in $(code --list-extensions)
	do
		code --force --install-extension $ext
	done

# NOW=$(date +"%Y-%m-%d %H:%M:%S")
# echo -e Updated VS-Code extensions on ${NOW} >> $HOME/cron_reports.txt
