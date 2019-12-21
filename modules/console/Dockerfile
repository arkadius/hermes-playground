FROM killercentury/nodejs-bower-grunt

COPY ./hermes-console/ /app/

WORKDIR /app

RUN npm i
RUN bower install --allow-root

CMD ./serve.js config.json
