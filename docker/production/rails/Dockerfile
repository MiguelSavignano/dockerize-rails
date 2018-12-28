FROM node:10.13.0-slim as nodejs

# ******Multi stage ********
FROM ruby:2.5.1-slim as builder

ARG RAILS_MASTER_KEY
ENV NODE_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=true

# Install common dev libs
RUN apt-get update -qq && apt-get install -y \
  build-essential

# Install Postgresql
RUN apt-get update -qq && apt-get install -y postgresql-client libpq-dev

# Install Nodejs 10.13.0 and Yarn 1.10.1
ENV NODE_VERSION 10.13.0
ENV YARN_VERSION 1.10.1
COPY --from=nodejs /usr/local/bin/ /usr/local/bin/
COPY --from=nodejs /usr/local/lib/ /usr/local/lib/
COPY --from=nodejs /opt/yarn-v1.10.1/ /opt/yarn-v1.10.1/
WORKDIR /app

# Invalidate gems cache if change Gemfile or Gemfile.lock
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 4 --without development test staging --deployment

# Invalidate node_modules cache if package.json or package-lock.json
COPY package.json package-lock.json /app/
RUN npm ci

# Copy app and public folder
COPY . .

COPY ./app/assets ./app/javascript /app/
RUN bundle exec rails assets:precompile

# ***************************************
# ************ Multi Stage **************
# ***************************************

FROM ruby:2.5.1-slim

ENV NODE_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=true

# system dependencies (rails need javascript runtime)
RUN apt-get update -qq && apt-get install -y libpq-dev nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# ***Copy only necessary files (.dockerignore don't work in multistage)***
COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY --from=builder /app/app /app/app
COPY --from=builder /app/config /app/config
COPY --from=builder /app/bin /app/bin
COPY --from=builder /app/db /app/db
COPY --from=builder /app/lib /app/lib
COPY --from=builder /app/storage /app/storage
COPY --from=builder /app/vendor /app/vendor
COPY --from=builder /app/public /app/public
COPY --from=builder /app/config.ru app/Gemfile app/Gemfile.lock app/Rakefile /app/


CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
