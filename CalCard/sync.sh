#!/bin/bash

# Enable globs
shopt -s extglob

calendarPath="/home/jeanclaude/.local/share/calendar/"

# Get from singlefile
echo "Sync singlefile"
vdirsyncer --config /home/jeanclaude/Dotfiles/CalCard/VdirSyncer/config sync calendars_to_singlefile

# Get from remote
echo "Sync remote"
vdirsyncer --config /home/jeanclaude/Dotfiles/CalCard/VdirSyncer/config sync calendars_to_remote

# Push to singlefile
echo "Sync singlefile"
vdirsyncer --config /home/jeanclaude/Dotfiles/CalCard/VdirSyncer/config sync calendars_to_singlefile

# Generate merged
echo "Create merged"
rm -fr "${calendarPath}/merged/personal"
rm -fr "${calendarPath}/merged/studies"

mkdir -p "${calendarPath}/merged/personal"
mkdir -p "${calendarPath}/merged/studies"

cp "${calendarPath}/regular/personal_"*"/"* "${calendarPath}/merged/personal"
cp "${calendarPath}/regular/studies_"*"/"* "${calendarPath}/merged/studies"

# Push merged
echo "Sync remote"
vdirsyncer --config /home/jeanclaude/Dotfiles/CalCard/VdirSyncer/config sync calendars_merged_to_remote

# Sync Calendar
echo "Sync singlefile"
vdirsyncer --config /home/jeanclaude/Dotfiles/CalCard/VdirSyncer/config sync contacts
