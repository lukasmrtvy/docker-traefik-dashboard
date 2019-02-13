# docker-traefik-dashboard

# Info
```
docker run -d --restart always -e URL=http://mytraefik:8080 --network traefik-network --name dash -p 9001:9001 lukasmrtvy/docker-traefik-dashboard:latest
```
# Variables
- AUTH_USER
- AUTH_PASSWORD
- SKIP_SSL_VERIFICATION 
- CUSTOM_CA 
- URL
- custom_cron
