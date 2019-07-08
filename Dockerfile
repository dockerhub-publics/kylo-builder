# FROM maven:3.5.3-jdk-8 AS build
FROM zenika/alpine-maven AS build

WORKDIR /root
ARG MAVEN_SKIP_RC=true  
ARG NODE_OPTIONS="--max-old-space-size=2048"
RUN apk update && apk add rpm # install apt update; apt install -y rpm && rm -rf /var/lib/apt/lists/*
RUN cd && curl https://s3-us-west-2.amazonaws.com/thinkbig.kylo/m2.tgz | tar xzC $HOME \
    && git clone https://github.com/Teradata/kylo && cd kylo && mvn -X clean install \
    && cd && rm -rf kylo && mv $HOME/.m2/repository/com/thinkbiganalytics/kylo $HOME/m2_kylo \
    && rm -rf $HOME/.m2

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build /root/m2_kylo m2_kylo
