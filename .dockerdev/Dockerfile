FROM ruby:2.6.5-slim-buster

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /var/tmp/* \
  && truncate -s 0 /var/log/*log

# postgres source
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' 11 > /etc/apt/sources.list.d/pgdg.list

# nodejs source
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-11 \
    nodejs \
    yarn=1.21.1-1 \
    ghostscript \
    imagemagick \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /var/tmp/* \
  && truncate -s 0 /var/log/*log

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN gem update --system \
  && gem install bundler:1.17.2

RUN mkdir -p /app

WORKDIR /app
