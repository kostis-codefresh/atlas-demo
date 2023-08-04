FROM arigaio/atlas:latest-alpine as atlas

FROM alpine:3.17.3

WORKDIR /

COPY --from=atlas /atlas .
RUN chmod +x /atlas

COPY migrations /migrations
COPY atlas.hcl atlas.hcl
