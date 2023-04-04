FROM bayedev/opencatd
EXPOSE 443
# docker run -d --name opencatd -e TLS_DOMAIN=muzlin-opencat.up.railway.app -p 80:80 -p 443:443 -v /srv/data:/opt/db -v /srv/certs:/opt/certs bayedev/opencatd
