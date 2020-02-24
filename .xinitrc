#!/bin/sh

xrdb -I$HOME ~/.Xresources

# Make sure pen stick the touchscreen
xinput --map-to-output 'Wacom Pen and multitouch sensor Finger touch' eDP-1
xinput --map-to-output 'Wacom Pen and multitouch sensor Pen stylus' eDP-1
xinput --map-to-output 'Wacom Pen and multitouch sensor Pen eraser' eDP-1

exec i3
