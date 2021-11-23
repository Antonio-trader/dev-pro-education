FROM ubuntu:20.04

USER root

RUN   apt-get -q -y update; apt-get -q -y upgrade && \
      apt-get -q -y install sudo openssh-server && \
      apt install -y python3 && \
      apt install python3-pip -y && \
      pip3 install ansible --upgrade && \
      mkdir /root/.ssh && \
      chmod 700 /root/.ssh && \
      mkdir /var/run/sshd && \
      mkdir /root/git_repo

RUN   apt install software-properties-common apt-transport-https -y && \
      add-apt-repository ppa:openjdk-r/ppa -y && \
      apt install openjdk-8-jdk -y

COPY remote-key.pub /root/.ssh/authorized_keys

#EXPOSE 22


CMD /usr/sbin/sshd -D