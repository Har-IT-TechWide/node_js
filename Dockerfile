FROM docker.repo1.chc.com/node:21-alpine

# Create and set ownership of the /app directory
RUN mkdir /app && chown -R 1001:1001 /app

# Create and set ownership of the 'logs' directory
USER root
RUN mkdir /app/logs && chown -R 1001:1001 /app/logs
USER 1001

# Configure npm registry
RUN echo 'https://repo1.chc.com/artifactory/dl-cdn/v3.18/community' > /etc/apk/repositories && \
    echo 'https://repo1.chc.com/artifactory/dl-cdn/v3.18/main' >> /etc/apk/repositories


# Update packages and install sudo
RUN apk update && apk add --no-cache sudo

WORKDIR /app

# Set npm registry
RUN npm config set registry https://repo1.chc.com/artifactory/api/npm/npm-virtual/

EXPOSE 3001

# Copy package files
COPY --chown=1001:1001 package.json yarn.lock package-lock.json* /app/

# Install dependencies
RUN npm install --force
RUN npm cache clean --force

# Set ownership and permissions for global node_modules
USER root
RUN chown -R root:1001 /usr/local/lib/node_modules
RUN chmod -R 775 /usr/local/lib/node_modules
USER 1001

# Copy the rest of the application code
COPY --chown=1001:1001 .. /app/

# Start the application
CMD ["yarn", "start"]

