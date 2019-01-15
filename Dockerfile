FROM       ubuntu:16.04
MAINTAINER Saint "https://github.com/lmspay"

RUN apt-get update

RUN apt-get install -y openssh-server telnet vim openjdk-8-jre tomcat7 curl net-tools iputils-ping libapr1-dev libssl-dev libtcnative-1
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY server.xml /etc/tomcat7/
RUN chown root:tomcat7 /etc/tomcat7/server.xml

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8080
EXPOSE 22

CMD ["/run.sh"]
#CMD    ["/usr/sbin/sshd", "-D"]
