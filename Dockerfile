FROM node:latest as build

RUN apt-get update && apt-get install -y yarn

