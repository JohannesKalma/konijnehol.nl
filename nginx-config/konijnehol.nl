server {

	root /var/www/vhosts/konijnehol.nl/html;

	index index.html;	

	server_name konijnehol.nl www.konijnehol.nl;
   	
	# --- LOGGING START ---
	access_log /var/log/nginx/konijnehol.nl.access.log;
	error_log  /var/log/nginx/konijnehol.nl.error.log;
	# --- LOGGING END ---

 	location / {
		try_files $uri $uri.html $uri/ =404;
 	}

   	# Block those PHP bots immediately and keep logs clean
 	location ~ \.php$ {
		##access_log off;
		return 444;
 	}

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/konijnehol.nl/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/konijnehol.nl/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}   
server {
    if ($host = www.konijnehol.nl) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = konijnehol.nl) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


   listen 80;
   server_name konijnehol.nl www.konijnehol.nl;
    return 404; # managed by Certbot




}
