FROM ubuntu:xenial

LABEL Maintainer=MOIN

ENV DEBIAN_FRONTEND noninteractive

##### update ubuntu
RUN apt-get update \
    && apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev \
    && apt-get install -y curl net-tools build-essential git wget unzip vim python python-setuptools python3-pip python-dev python-numpy openjdk-8-jdk \
    && apt-get -y install locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

######################################
#### ---- NodeJS from Ubuntu ---- ####
######################################
#RUN apt-get update -y && \
#    apt-get install -y git xz-utils && \
#    apt-get install -y nodejs npm && \
#    npm --version && \
#    apt-get install -y gcc g++ make
#########################################
#### ---- Node from NODESOURCES ---- ####
#########################################
# Ref: https://github.com/nodesource/distributions
ARG NODE_VERSION=${NODE_VERSION:-12}
ENV NODE_VERSION=${NODE_VERSION}
RUN apt-get update -y && \
    apt-get install -y sudo curl git xz-utils && \
    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y gcc g++ make && \
    apt-get install -y nodejs && \
    node -v && npm --version && \
    npm install npm -g


# install tzdata package
RUN apt-get update
ENV TZ=America/Edmonton
RUN apt-get -y install tzdata


# install puppeteer dependencies for ubuntu
RUN apt-get update && sudo apt install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget

# create a app directory in docker image
RUN mkdir /app

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Install npm packages
COPY package.json .
COPY package-lock.json .

#(1) Installs chromium so it's available in the container, (2) tells puppeteer not to install chromium, and (3) tells puppeteer what path it can find chromium at
RUN apt-get update
RUN apt-get install --assume-yes chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV CHROMIUM_PATH /usr/bin/chromium-browser

RUN npm install

# CMD ["npm", "run", "test"]