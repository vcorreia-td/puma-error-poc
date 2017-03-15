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

RUN gem install bundler

# Workaround for broken jruby image
# gem is not up to date
RUN gem update --system

ENV APP_HOME /my_service_name
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=10 \
  BUNDLE_PATH=/bundle

ARG BUNDLE_GITHUB__COM

RUN bundle install

ADD . $APP_HOME
