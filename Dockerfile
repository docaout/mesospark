FROM ubuntu:16.04

ENV LANG C.UTF-8
ENV TZ America/New_York

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    echo "deb http://repos.mesosphere.io/ubuntu xenial main" | tee /etc/apt/sources.list.d/mesosphere.list && \
    apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends default-jdk curl && \
    apt-get install -y mesos && \
    curl http://d3kbcqa49mib13.cloudfront.net/spark-2.0.1-bin-hadoop2.7.tgz | tar -xzC /opt && mv /opt/spark* /opt/spark && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/default-java/
ENV SPARK_HOME /opt/spark
ENV PATH ${SPARK_HOME}/bin:$PATH

CMD ["bash"]
