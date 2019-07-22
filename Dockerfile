FROM       ubuntu:16.04
MAINTAINER Saint "https://github.com/lmspay"

RUN apt-get update

RUN apt-get install -y language-pack-zh-hans tzdata nmon openssh-server telnet vim openjdk-8-jre tomcat7 curl net-tools iputils-ping libapr1-dev libssl-dev libtcnative-1
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

# 设置语言
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# 修改默认时区为CST
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY server.xml /etc/tomcat7/
RUN chown root:tomcat7 /etc/tomcat7/server.xml

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8080
EXPOSE 22

CMD ["/run.sh"]
