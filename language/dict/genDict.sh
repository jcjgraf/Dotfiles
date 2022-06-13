#!/usr/bin/sh

aspell -d de_CH dump master | aspell -l de_CH expand | sed --expression='s/ß/ss/g' > de_CH.dict
