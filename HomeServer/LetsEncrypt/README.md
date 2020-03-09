# Lets Encrypt

- Create one certificate for www and non-www as follows:
```
 sudo docker run -it --rm \
-v /home/jeanclaude/HomeServer/Ssl/etc/letsencrypt:/etc/letsencrypt \
-v /home/jeanclaude/HomeServer/Ssl/var/lib/letsencrypt:/var/lib/letsencrypt \
-v ${PWD}/Site:/data/letsencrypt \
-v /home/jeanclaude/HomeServer/Ssl/var/log/letsencrypt:/var/log/letsencrypt \
certbot/certbot \
certonly --webroot \
--email mail@jeanclaudegraf.ch --agree-tos --no-eff-email \
--webroot-path=/data/letsencrypt \
-d www.matrix.jeanclaudegraf.ch -d matrix.jeanclaudegraf.ch
```
