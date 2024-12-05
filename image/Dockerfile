FROM ubuntu:22.04

ENV TARGETARCH=linux-x64
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    wget \
    gnupg \
    software-properties-common

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Prepare Docker installation
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Prepare Terraform installation
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# Prepare Microsoft Open JDK 17 installation
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb

RUN apt-get update

# Install Microsoft Open JDK 17, Docker and Terraform
RUN apt-get install -qq --no-install-recommends msopenjdk-17 -y
RUN apt-get install -qq --no-install-recommends docker-ce -y
RUN apt-get install -qq --no-install-recommends terraform

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Fix vulnerabilities
RUN apt-get install -y python3 curl && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3

RUN pip3 install --upgrade cryptography>=42.0.0 \
    pyjwt>=2.4.0 \
    oauthlib>=3.2.2 \
    zipp>=3.19.1

WORKDIR /azp

COPY azure-pipelines-agent/start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
