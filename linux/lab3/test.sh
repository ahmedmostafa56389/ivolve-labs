#!/bin/bash

# Set the threshold and email address
THRESHOLD=37
RECIPIENT="ahmedmostafasaad638@gmail.com"
SENDER="ahmedmostafasaad638@gmail.com"

# Check disk space and send an email if usage exceeds the threshold
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
    # Extract the percentage value and the filesystem name
    usep=$(echo $output | awk '{ print $1 }' | sed 's/%//g')
    partition=$(echo $output | awk '{ print $2 }')

    # Check if the usage percentage exceeds the threshold
    if [ $usep -ge $THRESHOLD ]; then
        # Send an email using msmtp
        echo -e "Subject: Disk Space Alert: $partition usage at $usep%\nFrom: $SENDER\nTo: $RECIPIENT\n\nRunning out of space \"$partition ($usep%)\" on $(hostname) as of $(date)." | msmtp --debug --from=$SENDER -t $RECIPIENT
    fi
done

