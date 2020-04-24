FROM cypress/base:10
WORKDIR /app
# This allows for creating a package.json within the Dockerfile itself
RUN npm init --yes
RUN npm i cypress
# Copying both the test files and the config for cypress
COPY cypress cypress
COPY cypress.json .
# I had a local copy of this script, but it is easily findable online
COPY wait-for-it.sh
RUN chmod +x wait-for-it.sh

RUN echo "deb http://mirrors.kernel.org/ubuntu/ xenial main" |  tee -a /etc/apt/sources.list &&  apt-get update &&  apt install -y --allow-unauthenticated libpng12-0

RUN apt-get update && \
    apt-get install -y python3-pip libpng-dev && \
    pip3 install --upgrade awscli && \
    rm -rf /var/lib/apt/lists/*
