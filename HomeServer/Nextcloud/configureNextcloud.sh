#!/bin/sh

sudo docker exec -u www-data nextcloud php occ config:system:set trusted_domains 2 --value="localhost"
sudo docker exec -u www-data nextcloud php occ config:system:set trusted_domains 3 --value="nc.jeanclaudegraf.ch"
sudo docker exec -u www-data nextcloud php occ config:system:set trusted_domains 4 --value="www.nc.jeanclaudegraf.ch"

sudo docker exec -u www-data nextcloud php occ config:system:set default_language --value="de"

sudo docker exec -u www-data nextcloud php occ config:system:set default_locale --value="de_CH"

# Disable Help Menu
sudo docker exec -u www-data nextcloud php occ config:system:set knowledgebaseenabled --value="false" --type=boolean

sudo docker exec -u www-data nextcloud php occ config:system:set allow_user_to_change_display_name --value="false" --type=boolean

# Set path for default files dir
sudo docker exec -u www-data nextcloud php occ config:system:set skeletondirectory --value="/srv/nextcloud/presents/"

sudo docker exec -u www-data nextcloud php occ config:system:set overwritehost --value="nc.jeanclaudegraf.ch"

sudo docker exec -u www-data nextcloud php occ config:system:set overwriteprotocol --value="https"

# Set base url for generating nc urls
sudo docker exec -u www-data nextcloud php occ config:system:set overwrite.cli.url --value="https://www.nc.jeanclaudegraf.ch"

sudo docker exec -u www-data nextcloud php occ config:system:set htaccess.RewriteBase --value="/"

sudo docker exec -u www-data nextcloud php occ config:system:set overwritewebroot --value="/"
sudo docker exec -u www-data nextcloud php occ maintenance:update:htaccess 

sudo docker exec -u www-data nextcloud php occ config:system:set loglevel --value="2"

sudo docker exec -u www-data nextcloud php occ config:system:set logtimezone --value="Europe/Berlin"
