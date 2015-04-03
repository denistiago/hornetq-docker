FROM dockerfile/java:oracle-java8

USER root
WORKDIR /opt
RUN wget -q -O - http://downloads.jboss.org/hornetq/hornetq-2.4.0.Final-bin.tar.gz | tar -C . -xz
RUN ln -s hornetq-2.4.0.Final hornetq
ADD hornetq-configuration.xml /opt/hornetq/config/stand-alone/non-clustered/hornetq-configuration.xml
ADD hornetq-jms.xml /opt/hornetq/config/stand-alone/non-clustered/hornetq-jms.xml
ADD run-hornet.sh /opt/hornetq/bin/
RUN chmod +x /opt/hornetq/bin/run-hornet.sh

VOLUME ["/opt/hornetq/data","/opt/hornetq/logs"]

ENV HORNETQ_HOME /opt/hornetq

EXPOSE 5445

WORKDIR /opt/hornetq/bin
CMD ./run-hornet.sh
