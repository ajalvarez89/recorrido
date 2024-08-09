FROM ruby:3.2.2

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Setup our bundler version specifically
ENV BUNDLER_VERSION='2.4.15'
RUN gem install bundler --no-document -v '2.4.15'

COPY . /usr/src/app/
WORKDIR /usr/src/app

RUN bundle install
