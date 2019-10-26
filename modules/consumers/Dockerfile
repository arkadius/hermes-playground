FROM jeanblanchard/java:8

RUN apk update \
  && apk add unzip bash \
  && rm -rf /var/cache/apk/*

ENV HERMES="hermes-consumers.zip"

ADD hermes-consumers-*.zip /tmp/${HERMES}
RUN unzip -q "/tmp/${HERMES}" -d /opt \
  && rm "/tmp/${HERMES}" \
  && mv /opt/hermes-consumers-* /opt/hermes-consumers

ENV HERMES_CONSUMERS_OPTS="-Darchaius.configurationSource.additionalUrls=file:///etc/hermes/consumers.properties -Dlogback.configurationFile=/etc/hermes/logback.xml"
ADD consumers.properties /etc/hermes/consumers.properties
ADD logback.xml /etc/hermes/logback.xml

CMD /opt/hermes-consumers/bin/hermes-consumers
