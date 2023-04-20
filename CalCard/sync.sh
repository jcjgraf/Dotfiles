#!/bin/bash

# Enable globs
shopt -s extglob

calendarPath="/home/jeanclaude/.local/share/calendar/"

# Get from singlefile
vdirsyncer sync calendars_to_singlefile

# Get from remote
vdirsyncer sync calendars_to_remote

# Push to singlefile
vdirsyncer sync calendars_to_singlefile

# Generate merged
rm -fr "${calendarPath}/merged/personal"
rm -fr "${calendarPath}/merged/studies"

mkdir -p "${calendarPath}/merged/personal"
mkdir -p "${calendarPath}/merged/studies"

cp "${calendarPath}/regular/personal_"*"/"* "${calendarPath}/merged/personal"
cp "${calendarPath}/regular/studies_"*"/"* "${calendarPath}/merged/studies"

# Push merged
vdirsyncer sync calendars_merged_to_remote

# Sync Calendar
vdirsyncer sync contacts
