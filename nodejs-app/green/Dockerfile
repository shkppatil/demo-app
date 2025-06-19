FROM node:18-alpine
WORKDIR /app
COPY app.js .
RUN npm init -y && npm install express
ENV VERSION=green
CMD ["node", "app.js"]