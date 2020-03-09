# Gitea Infos

- The ownership of some folders may have to get changed inside the container such that user `git` has permissions
- Some settings cannot be set properly through env variables and need to be set manually during the installation
- When changing the SSH port of the docker container, we need to add option `SSH_DOMAIN = <myDomain>:<newPort>` to the `app.ini` file 
