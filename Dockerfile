FROM centos/python-35-centos7:latest

USER root

# Install required RPMs and ensure that the packages were installed
RUN yum install -y java-1.8.0-openjdk wget \
    && yum clean all && rm -rf /var/cache/yum \
    && rpm -q java-1.8.0-openjdk wget

RUN mkdir -p /mnt/bucket-test
RUN yum -y install epel-release
RUN yum -y install s3fs-fuse
RUN yum install -y python3
RUN yum install -y python-pip
RUN yum install python3-pip
RUN /usr/bin/pip3 install --upgrade pip
RUN /usr/bin/pip3 install awscli

# directory
RUN wget http://mirror.vorboss.net/apache/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz
RUN tar -xvzf spark-2.4.5-bin-hadoop2.7.tgz
RUN mv spark-2.4.5-bin-hadoop2.7 spark
RUN mkdir -p /opt
RUN mv spark /opt
ADD aws-java-sdk-1.7.4.jar /opt/spark/jars
ADD jets3t-0.9.4.jar /opt/spark/jars
ADD hadoop-aws-2.7.3.jar /opt/spark/jars

# Environment variables
ENV \
    JBOSS_IMAGE_NAME="radanalyticsio/openshift-spark" \
    JBOSS_IMAGE_VERSION="2.4-latest" \
    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/spark/bin" \
    SCL_ENABLE_CMD="scl enable rh-python36" \
    SPARK_HOME="/opt/spark" \
    SPARK_INSTALL="/opt/spark-distro" \
    STI_SCRIPTS_PATH="/usr/libexec/s2i"

# Labels
LABEL \
      io.cekit.version="2.2.7"  \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"  \
      maintainer="madhukar.ponnala@experian.com" \
      name="experian-spark"  \
      org.concrt.version="2.2.7"  \
      sparkversion="2.4.5"  \
      version="2.4-latest"

# Add scripts used to configure the image
RUN mkdir -p /tmp/scripts
ADD entrypoint /tmp/scripts
ADD launch.sh /tmp/scripts
ADD  modules /tmp/scripts

# Custom scripts
USER root
RUN [ "bash", "-x", "/tmp/scripts/common/install" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/metrics/install" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/spark/install" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/s2i/install" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/python36/install" ]

# Modify permission for Openshift platform
RUN chgrp -R 0 /tmp/* && \
    chmod -R g=u /tmp/*
RUN chmod g=u /etc/passwd

USER 1001

EXPOSE 8080 80 443 7077

# Specify the working directory
WORKDIR /tmp

ENTRYPOINT ["/entrypoint"]

CMD ["/launch.sh"]