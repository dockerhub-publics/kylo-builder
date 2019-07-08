FROM maven:3.5.3-jdk-8

RUN apt update; apt install -y rpm
RUN curl https://s3-us-west-2.amazonaws.com/thinkbig.kylo/m2.tgz | tar xzC $HOME
RUN git clone https://github.com/Teradata/kylo
ARG MAVEN_SKIP_RC=true
ARG NODE_OPTIONS="--max-old-space-size=4096"
RUN cd kylo; mvn clean install; cd ; rm -rf kylo
RUN mv $HOME/.m2/repository/com/thinkbiganalytics/kylo $HOME/m2_kylo
RUN rm -rf $HOME/.m2
