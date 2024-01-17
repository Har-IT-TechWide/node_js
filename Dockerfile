
FROM docker.repo1.chc.com/node: 21-alpine
RUN mkdir /app & chown node:node /app
RUN echo 'https://repo1.chc.com/artifactory/dl-cdn/v3.18/community' > /etc/apk/repositories
RUN echo 'https://repo1.chc.com/artifactory/dl-cdn/v3.18/main' >> /etc/apk/repositories
RUN apk upgrade-update-cache-available
RUN apt-get update && apt-get install -y sudo
WORKDIR /app
RUN npm config set registry https://repo1.chc.com/artifactory/api/npm/npm-virtual/
EXPOSE 3001
USER node
COPY -chown=node:node package.json yarn.lock package-lock.json* /app
RUN npm install -forces
RUN npm cache clean -force
RUN SUDO chown -R root:${whoami} /usr/local/lib/node_modules
RUN SUDO chown -R 775 /usr/local/lib/node_modules
COPY -chown=node:node ..
USER node
CMD ["yarn", "start"]
