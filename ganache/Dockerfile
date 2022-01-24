FROM alpine:latest
RUN apk add npm
RUN npm install ganache@alpha -g
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]