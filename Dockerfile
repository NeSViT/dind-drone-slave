FROM ubuntu:14.04
MAINTAINER jerome.petazzoni@docker.com

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
ADD devdockerCA.crt /usr/local/share/ca-certificates/docker-dev-cert/
RUN update-ca-certificates
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh
#RUN docker login --username=docker --password=pocker --email=docker@lab.int  https://registry.lab.int/
# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]

