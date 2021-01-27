#!/bin/bash

maim -s /home/im/Pictures/Screenshots/$(date +%s).png && mkdir -p /home/im/Pictures/Screenshots/sc.$(date +%y%m) && mv /home/im/Pictures/Screenshots/*png /home/im/Pictures/Screenshots/sc.$(date +%y%m) && ls -v /home/im/Pictures/Screenshots/sc.$(date +%y%m)/*png | cat -n | while read n f; do mv -n "$f" "/home/im/Pictures/Screenshots/$n.sc.png"; done
