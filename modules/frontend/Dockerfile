FROM jeanblanchard/java:8

RUN apk update \
  && apk add unzip bash \
  && rm -rf /var/cache/apk/*

ENV HERMES="hermes-frontend.zip"

ADD hermes-frontend-*.zip /tmp/${HERMES}
RUN unzip -q "/tmp/${HERMES}" -d /opt \
  && rm "/tmp/${HERMES}" \
  && mv /opt/hermes-frontend-* /opt/hermes-frontend

ENV HERMES_FRONTEND_OPTS="-Darchaius.configurationSource.additionalUrls=file:///etc/hermes/frontend.properties -Dlogback.configurationFile=/etc/hermes/logback.xml"
ADD frontend.properties /etc/hermes/frontend.properties
ADD logback.xml /etc/hermes/logback.xml

CMD /opt/hermes-frontend/bin/hermes-frontend
