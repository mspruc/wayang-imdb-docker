FROM apache-wayang-base:latest

RUN mkdir -p /var/www/html
COPY . /var/www/html
WORKDIR /var/www/html

ENV MAVEN_CONFIG ""

# Aliases for builds
RUN echo 'rebuild () { cd /var/www/html && mvn -T 1C clean install -DskipTests -Drat.skip=true -Dmaven.javadoc.skip=true -Dmaven.test.skip -pl :"$1" && mvn -T 1C clean package -DskipTests -Dmaven.javadoc.skip=true -pl :"$1"; }' >> /root/.bashrc && \
    echo 'assemble () { mvn -T 1C clean package -DskipTests -Dmaven.javadoc.skip=true -pl :wayang-assembly -Pdistribution && cd wayang-assembly/target && tar -xvf apache-wayang-assembly-0.7.1-incubating-dist.tar.gz && cd wayang-0.7.1; }' >> /root/.bashrc

ENTRYPOINT "/bin/bash"

