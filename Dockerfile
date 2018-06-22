FROM node:10.5.0-slim
RUN npm install -g json-server curl

ADD run.sh default.json /
ENTRYPOINT ["bash", "/run.sh"]
CMD []
