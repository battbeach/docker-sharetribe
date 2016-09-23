FROM ubuntu:xenial
MAINTAINER Leonel Baer <leonel@lysender.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get -y update && \
    apt-get -y install nodejs curl git libxml2 && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
    curl -L https://get.rvm.io | bash -s stable && \
    /bin/bash -l -c "rvm requirements" && \
    /bin/bash -l -c "rvm install 2.3.1" && \
    /bin/bash -l -c "gem install bundler --no-ri --no-rdoc" && \
    apt-get -y install build-essential mysql-client libmysqlclient-dev libxslt-dev libxml2-dev sphinxsearch imagemagick && \
    /bin/bash -l -c "gem install mysql2 -v 0.4.4" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directory for Sharetribe
RUN /bin/bash -l -c "mkdir -p /opt/sharetribe"
WORKDIR /opt/sharetribe

# Run Bundle install
ADD Gemfile /opt/sharetribe/Gemfile
ADD Gemfile.lock /opt/sharetribe/Gemfile.lock
RUN /bin/bash -l -c "bundle install"

EXPOSE 3000

