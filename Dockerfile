FROM docker.repo1.chc.com/node:21-alpine

# Create application directory and logs directory with appropriate ownership
RUN mkdir /app && chown node:node /app
RUN mkdir /app/logs && chown node:node /app/logs

# Add custom repositories (if still needed)
RUN echo 'https://repo1.chc.com/artifactory/dl-cdn/v3.18/community' > /etc/apk/repositories
RUN echo 'https://repo1.chc.com/artifactory/dl-cdn/v3.18/main' >> /etc/apk/repositories
RUN apk upgrade-update-cache-available

# Set working directory
WORKDIR /app

# Configure NPM registry
RUN npm config set registry https://repo1.chc.com/artifactory/api/npm/npm-virtual/

# Expose port
EXPOSE 3001

# Copy package files and install dependencies
COPY --chown=node:node package*.json .yarnrc.yml /app/
RUN npm install -forces

# Copy remaining application files
COPY --chown=node:node . /app/

# Switch to non-root user
USER node

# Start the application
CMD ["yarn", "start"]
