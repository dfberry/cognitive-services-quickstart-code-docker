# docker build -t diberry/cog-serv-quickstart-code .
# docker run -it --rm --env-file=.env cog-serv-quickstart-code

FROM ubuntu:18.04

# utils and wget
RUN apt update -y && \
  apt-get install -y apt-utils && \
  apt-get install -y wget && \
  apt-get install -y nodejs && \
  apt-get install -y npm && \
  apt-get install -y golang-go && \
  apt-get install -y git && \
  apt-get install nano

# install java - man dir creation required for install
#RUN mkdir -p /usr/share/man/man1 && \
# apt install -y openjdk-11-jdk

# Azure Cli
# this either adds python3 or it is already there
RUN wget https://aka.ms/InstallAzureCLIDeb -O ./usr/local/bin/InstallAzureCLIDeb.sh
RUN ./bin/bash ./usr/local/bin/InstallAzureCLIDeb.sh

## .NET Core 3.x
# https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-current
RUN apt-get install -y gpg && \
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
  mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
  wget -q https://packages.microsoft.com/config/ubuntu/18.04/prod.list && \
  mv prod.list /etc/apt/sources.list.d/microsoft-prod.list && \
  chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg && \
  chown root:root /etc/apt/sources.list.d/microsoft-prod.list && \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-3.0

WORKDIR /usr/src/

RUN git clone https://github.com/Azure-Samples/cognitive-services-quickstart-code

WORKDIR /usr/src/cognitive-services-quickstart-code
