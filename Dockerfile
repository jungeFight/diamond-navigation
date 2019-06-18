FROM node:latest as build

COPY . /project/

WORKDIR /project

ENV YARN_VERSION 1.13.0

RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN echo "Installing dependencies..." && \
    yarn install
RUN echo "Starting dist build..." && \
    yarn run build

