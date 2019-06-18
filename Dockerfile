FROM node:alpine as build

COPY . /project/

WORKDIR /project

RUN npm --registry https://registry.npm.taobao.org info underscore

RUN echo "Installing dependencies..." && \
    npm install
RUN echo "Starting dist build..." && \
    npm run-script build