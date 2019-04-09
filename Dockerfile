FROM ubuntu:16.04
RUN apt-get update -y
RUN apt-get install software-properties-common -y
RUN apt-get update -y
RUN apt-get -y install python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install certbot-dns-route53
COPY ./generate.sh /opt/generate.sh
RUN chmod 755 /opt/generate.sh