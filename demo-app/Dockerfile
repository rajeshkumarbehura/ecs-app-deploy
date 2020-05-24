FROM node:14.3.0-buster-slim

RUN mkdir -p /demo-app

WORKDIR /demo-app

COPY package*.json ./

COPY yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build

WORKDIR ./

# EXPOSE 9001
EXPOSE 80

RUN mkdir /var/logs

CMD ["node" , "./dist/main.js", "2>server.log"]
