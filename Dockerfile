# ****************************
# ******Build base stage******
# ****************************

FROM node:10.16.3-slim as nodejs

FROM ruby:2.6.3-slim as development

# Install common libs
RUN apt-get update -qq && apt-get install -y \
  build-essential vim git

# # Install Postgresql
# RUN apt-get install -y postgresql-client libpq-dev

# Install sqlite
RUN apt-get install -y sqlite3 libsqlite3-dev
# Install Nodejs
ENV NODE_VERSION=10.16.3
COPY --from=nodejs /usr/local/bin/ /usr/local/bin/
COPY --from=nodejs /usr/local/lib/ /usr/local/lib/
COPY --from=nodejs /opt/yarn-v1.17.3/ /opt/yarn-v1.17.3/

WORKDIR /app

# Production config
ARG BUNDLE_DEPLOYMENT=true
ARG BUNDLE_WITHOUT="development test staging"
ARG NODE_ENV=production
ARG RAILS_ENV=production

ENV BUNDLE_DEPLOYMENT=$BUNDLE_DEPLOYMENT BUNDLE_WITHOUT=$BUNDLE_WITHOUT
ENV NODE_ENV=$NODE_ENV
RUN RAILS_ENV=$RAILS_ENV

# Gems cache layer
RUN gem install bundler
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 4

# Node modules cache layer
COPY package.json package-lock.json /app/
RUN npm ci

COPY . .
CMD "./entrypoint.sh"

# ****************************
# ******Production stage******
# ****************************

FROM development as production-builder

ENV RAILS_ENV=production SECRET_KEY_BASE=1
# Build production assets
RUN bundle exec rails assets:precompile

RUN rm -r node_modules

# **********************************
# ******Final production Stage******
# **********************************

FROM ruby:2.6.3-slim

ENV NODE_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=true

# Install system dependencies

COPY --from=nodejs /usr/local/ /usr/local/

RUN apt-get update -qq && apt-get install -y \
  sqlite3 libsqlite3-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# RUN groupadd -r deploy && useradd -r -g deploy deploy
# USER deploy

# COPY --from=production-builder --chown=deploy:deploy /usr/local/bundle /usr/local/bundle
# COPY --from=production-builder --chown=deploy:deploy /app /app
ENV SECRET_KEY_BASE=1

COPY --from=production-builder /usr/local/bundle /usr/local/bundle
COPY --from=production-builder /app /app

CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
