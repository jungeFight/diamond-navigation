FROM node:carbon

WORKDIR /app
COPY . /app/

RUN npm --registry https://registry.npm.taobao.org info underscore

RUN echo "Installing dependencies..." && \
    npm install 
RUN echo "Starting dist build..." && \
    npm run build
RUN npm -g install serve

EXPOSE 8086
# 如需部署静态文件，使用：
CMD ["serve", "-s", "dist", "-p", "8086"]

