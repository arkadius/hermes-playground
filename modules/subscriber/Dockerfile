FROM jeanblanchard/java:8

EXPOSE 8099
EXPOSE 443

RUN apk add nginx
RUN mkdir /run/nginx
RUN mkdir /etc/ssl/certs/

COPY nginx-selfsigned.key /etc/ssl/private/
COPY nginx-selfsigned.crt /etc/ssl/certs/

COPY default.conf /etc/nginx/conf.d/
RUN nginx -t

COPY build/libs/hermes-subscriber-*.jar /opt/hermes-subscriber.jar

CMD nginx && java -jar /opt/hermes-subscriber.jar
