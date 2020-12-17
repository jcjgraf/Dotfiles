#!/bin/bash

/home/jeanclaude/bin/rsync_tmbackup.sh --rsync-append-flags "--exclude=/jeanclaude/.cache --exclude=*/lost+found" /home/jeanclaude jeanclaude@192.168.1.5:Backup/Arch
