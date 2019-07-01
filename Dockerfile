FROM ruby:2.6.3-alpine

RUN apk update \
&& apk add ruby \
           ruby-bigdecimal \
           ruby-bundler \
           ruby-io-console \
           ruby-rdoc \
           ruby-irb \
           ca-certificates \
           libressl \
           less \
&& apk add --virtual build-dependencies \
           build-base \
           ruby-dev \
           libressl-dev \
&& gem install bundler \
&& gem cleanup \
&& apk del build-dependencies \
&& rm -rf /usr/lib/ruby/gems/*/cache/* \
          /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*
