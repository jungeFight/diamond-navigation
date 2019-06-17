FROM node:alpine as build

COPY . /project/

WORKDIR /project

RUN apt-get update && sudo apt-get install yarn

RUN echo "Installing dependencies..." && \
    yarn install
RUN echo "Starting dist build..." && \
    yarn run build

FROM nginx:stable-alpine

COPY --from=build /project/dist /usr/share/nginx/html/

EXPOSE 80
