FROM nginx:alpine

EXPOSE 443
EXPOSE 8080

RUN mkdir -p /run/nginx
RUN mkdir -p /etc/ssl/certs/

COPY nginx-selfsigned.key /etc/ssl/private/
COPY nginx-selfsigned.crt /etc/ssl/certs/

COPY default.conf /etc/nginx/conf.d/
RUN nginx -t

COPY server /opt/

CMD nginx && /opt/server
