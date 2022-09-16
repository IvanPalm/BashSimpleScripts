#!/bin/bash
#date 14.09.2021
#update 15.10.2021
#author Ivan Palmegiani
#purpose Move all excel files from directory and subdirectories into folder renaming with previous directories to track duplicates. 

find $1 -type f -iname *xlsx -exec mv --backup=numbered -t $2 {} + 

# END
