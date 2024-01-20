FROM docker.repol.uhc.com/node: 21-alpine
RUN mkdir /app && chown node:node/app
RUN mkdir /app/logs && chown node:node/app/logs

# Create application directory and logs directory with appropriate ownership

RUN echo 'https://repol.uhc.com/artifactory/dl-cdn/v3.18/community' > /etc/apk/repositories
RUN echo 'https://repol.uhc.com/artifactory/dl-cdn/v3.18/main' >> /etc/apk/repositories
#Set working directory

WORKDIR /app

#Configure NPM registry

RUN npm config set registry https://repol.uhc.com/artifactory/api/npm/npm-virtual/


# Expose port

EXPOSE 3001


COPY -chown=node:node package.json yarn. lock package-lock.json* /app/

RUN npm install -forces 
RUN npm cache clean-force
COPY -chown-node:node. /app/

CMD ["yarn", "start"]