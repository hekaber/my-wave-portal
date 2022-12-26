# syntax=docker/dockerfile:1

FROM node:18-alpine3.16
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
COPY app/ .
RUN yarn install
EXPOSE 8080
CMD ["yarn", "start"]