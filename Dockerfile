FROM jruby:9.1.7.0
MAINTAINER Talkdesk DevOps <devops@talkdesk.com>

RUN \
  apt-get update && \
  apt-get install -y --force-yes \
    wget \
    build-essential \
    git \
    && \
  apt-get autoremove -y --force-yes && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DOCKERIZE_VERSION v0.2.0

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN gem install bundler

ENV APP_HOME /contacts_intake_worker
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=10 \
  BUNDLE_PATH=/bundle

ARG BUNDLE_GITHUB__COM

RUN bundle install

ADD . $APP_HOME
