#!/bin/bash
#date 16.09.2022
#update 
#author Ivan Palmegiani
#purpose Update all extensions in VC Code 

TODAY=$(date +"%Y-%m-%d")

# for ext in $(code --list-extensions)
# 	do
# 		code --force --install-extension $ext
# 	done

echo -e Updated VS-Code extensions on ${TODAY} >> cron_reports.txt
