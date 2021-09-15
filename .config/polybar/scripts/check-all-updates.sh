#!/bin/bash

sleep 5
#wget -q --tries=10 --timeout=20 --spider http://www.yaseenins.com > /dev/null
wget -q --tries=10 --timeout=20 --spider http://archlinux.org 2> /dev/null
if [[ $? -eq 0 ]]; then
   if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
       updates_arch=0
   fi

   if ! updates_aur=$(paru -Qu --aur --quiet | wc -l); then
       updates_aur=0
   fi
  updates=$(("$updates_arch" + "$updates_aur"))

   if [ "$updates" -gt 0 ]; then
      echo " $updates"
   else
      echo "0"
   fi
else
    echo "Offline"
fi
