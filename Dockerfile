FROM centos:latest
RUN yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

RUN yum-config-manager --disable docker-ce-nightly --nobest

RUN yum install java-11-openjdk.x86_64 -y

RUN yum install git -y

RUN yum install python36

RUN yum install wget -y

RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo

RUN rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
RUN yum install jenkins -y
CMD /etc/alternatives/java -Dcom.sun.akuma.Daemon=daemonized -Djava.awt.headless=true -DJENKINS_HOME=/var/lib/jenkins -jar /usr/lib/jenkins/jenkins.war --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war --daemon --httpPort=8080 --debug=5 --handlerCountMax=100 --handlerCountMaxIdle=20
