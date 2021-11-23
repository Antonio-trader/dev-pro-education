FROM jenkins/jenkins

USER root

RUN apt update -y && \
    apt install -y python3 && \
    apt install python3-pip -y && \
    pip3 install ansible --upgrade

USER jenkins
