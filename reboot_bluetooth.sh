#! /bin/bash
#date 17.01.2022
#update 
#author Ivan Palmegiani
#purpose Reboot the bluetooth unit 

sudo rmmod btusb
sudo modprobe btusb

# END
