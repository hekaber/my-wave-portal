FROM node:18-alpine3.16
RUN npm install -g yarn
WORKDIR /usr/src/app
COPY package.json ./
RUN yarn install
EXPOSE 8080
CMD yarn start