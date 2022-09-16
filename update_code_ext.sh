#!/bin/bash
#date 16.09.2022
#update 
#author Ivan Palmegiani
#purpose Update all extensions in VC Code 

for ext in $(code --list-extensions)
	do
		code --force --install-extension $ext
	done