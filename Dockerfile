FROM maven:3.5.3-jdk-8

RUN apt update; apt install -y rpm
RUN curl https://s3-us-west-2.amazonaws.com/thinkbig.kylo/m2.tgz | tar xzC $HOME
RUN git clone https://github.com/Teradata/kylo
RUN cd kylo; mvn clean install

# take artefacts from $HOME/.m2/repository/com/thinkbiganalytics/kylo
