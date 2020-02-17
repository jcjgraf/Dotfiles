# Nextcloud Setup

## Important Points
- Data dir must have owerneship `82:82` (web user)

- Scan `sudo docker exec -u www-data nextcloud php occ files:scan --all`

- Run `configureNextcloud.sh` script after installation
