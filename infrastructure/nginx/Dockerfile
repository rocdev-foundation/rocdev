FROM nginx:1.13
CMD /bin/bash -c " \
    envsubst '\$ROCDEV_APP_HOST \$ROCDEV_EMAIL_HOST' \
      < /etc/nginx/conf.d/default.conf \
      > /etc/nginx/conf.d/default.conf \
    && \
    nginx -g 'daemon off;' \
    "
RUN rm /usr/share/nginx/html/index.html
COPY security.txt /usr/share/nginx/html/.well-known/security.txt
COPY robots.txt /usr/share/nginx/html/robots.txt
COPY favicon.ico /usr/share/nginx/html/favicon.ico
COPY rocdev.vh.conf /etc/nginx/conf.d/default.conf
COPY humans.txt /usr/share/nginx/html/humans.txt
