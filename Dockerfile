FROM node:latest
RUN npm install -g json-server curl

WORKDIR /data
VOLUME /data

ADD run.sh default.json /
ENTRYPOINT ["bash", "/run.sh"]
CMD []
