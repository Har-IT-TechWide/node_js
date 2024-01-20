FROM docker.repol.chc.com/node:21-alpine

RUN mkdir /app && chown node:node /app
RUN mkdir /app/logs && chown node:node /app/logs

RUN echo 'https://repol.chc.com/artifactory/dl-cdn/v3.18/community' > /etc/apk/repositories
RUN echo 'https://repol.chc.com/artifactory/dl-cdn/v3.18/main' >> /etc/apk/repositories

WORKDIR /app

RUN npm config set registry https://repol.chc.com/artifactory/api/npm/npm-virtual/

EXPOSE 3000

COPY -chown=node:node package.json yarn.lock package-lock.json* /app/

RUN npm install -force
RUN npm cache clean --force

COPY -chown=node:node . /app/
RUN chown -R node:node /app/node_modules/.cache  # Ensure correct ownership of .cache

USER node  # Switch to non-root user

CMD ["yarn", "start"]
