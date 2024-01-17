#!/bin/sh
#date (dd.mm.yyyy) 16.09.2022
#update 12.11.2022
#author Ivan Palmegiani
#purpose Update all extensions in VC Code 

NOW=$(date +"%Y-%m-%d %H:%M:%S")

for ext in $(code --list-extensions)
	do
		code --force --install-extension $ext
	done

echo -e Updated VS-Code extensions on ${NOW} >> $HOME/cron_reports.txt
