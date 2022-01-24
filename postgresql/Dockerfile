FROM postgres:14-alpine
RUN adduser -D chainlinknode
ENV POSTGRES_PASSWORD=chainlinknode
ENV POSTGRES_USER=chainlinknode
RUN chown  -R chainlinknode /var/lib/postgresql/data /var/run/postgresql
USER chainlinknode