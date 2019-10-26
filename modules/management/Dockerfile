FROM jeanblanchard/java:8

RUN apk update \
  && apk add unzip bash \
  && rm -rf /var/cache/apk/*

ENV HERMES="hermes-management.zip"

ADD hermes-management-*.zip /tmp/${HERMES}
RUN unzip -q "/tmp/${HERMES}" -d /opt \
  && rm "/tmp/${HERMES}" \
  && mv /opt/hermes-management-* /opt/hermes-management

ENV SPRING_CONFIG_LOCATION="file:///etc/hermes/management.yaml"
ADD management.yaml /etc/hermes/management.yaml

CMD /opt/hermes-management/bin/hermes-management
