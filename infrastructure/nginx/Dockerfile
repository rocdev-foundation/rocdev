FROM nginx:1.13
RUN rm /usr/share/nginx/html/index.html
COPY rocdev.vh.conf /etc/nginx/conf.d/default.conf
COPY robots.txt /usr/share/nginx/html/robots.txt
COPY security.txt /usr/share/nginx/html/.well-known/security.txt
COPY humans.txt /usr/share/nginx/html/humans.txt
