#!/bin/bash
#date 10.02.2022
#update 
#author Ivan Palmegiani
#purpose Exports markdown to Word document

pandoc -f markdown -t docx $1 -o $2 
