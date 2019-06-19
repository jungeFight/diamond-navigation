FROM node:alpine

WORKDIR /project

RUN npm --registry https://registry.npm.taobao.org info underscore

