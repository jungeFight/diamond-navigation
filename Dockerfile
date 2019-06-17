FROM node:alpine as build

COPY . /project/

WORKDIR /project

ENV YARN_VERSION 1.13.0

RUN apk add --no-cache --virtual .build-deps-yarn curl \
    && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz \
    && apk del .build-deps-yarn

RUN echo "Installing dependencies..." && \
    yarn install
RUN echo "Starting dist build..." && \
    yarn run build

FROM nginx:stable-alpine

COPY --from=build /project/dist /usr/share/nginx/html/

EXPOSE 80
