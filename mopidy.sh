#!/bin/bash

# Define the card
TARGET_INTERFACE="UAC1 \[iFi USB Audio SE UAC1\]"

# Search the card bus
card_number=$(aplay -l | grep -A 1 "$TARGET_INTERFACE" | grep "^card" | awk -F'card |:' '{print $2}')

#Search the card number on mopidy.conf
mopidy_card=$(cat ~/.config/mopidy/mopidy.conf | grep output | awk -F'hw:|,' '{print $2}')

#FUNCTION COMPARE VARIABLES
if [ "$card_number" = "$mopidy_card" ]; then
	nohup mopidy > /dev/null 2>&1 &

else
	sed -i "s/$mopidy_card/$card_number/" ~/.config/mopidy/mopidy.conf
	nohup mopidy > /dev/null 2>&1 &
fi

