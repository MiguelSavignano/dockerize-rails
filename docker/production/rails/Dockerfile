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
ENV NODE_VERSION=10.13.0 YARN_VERSION=1.10.1
COPY --from=nodejs /usr/local/bin/ /usr/local/bin/
COPY --from=nodejs /usr/local/lib/ /usr/local/lib/
COPY --from=nodejs /opt/yarn-v1.10.1/ /opt/yarn-v1.10.1/

WORKDIR /app

# Invalidate gems cache if change Gemfile or Gemfile.lock
COPY Gemfile Gemfile.lock /app/
RUN bundle install -j 4 --without development test staging --deployment

# Invalidate node_modules cache if package.json or yarn.lock
COPY package.json yarn.lock /app/
RUN yarn install --pure-lockfile

# Copy app and public folder
COPY . .

RUN bundle exec rails assets:precompile
RUN rm -r node_modules

# ***************************************
# ************ Multi Stage **************
# ***************************************

FROM ruby:2.5.1-slim

ENV NODE_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=true

# Install Nodejs 10.13.0 and Yarn 1.10.1 (rails need javascript runtime)
ENV NODE_VERSION=10.13.0 YARN_VERSION=1.10.1
COPY --from=nodejs /usr/local/bin/ /usr/local/bin/
COPY --from=nodejs /usr/local/lib/ /usr/local/lib/
COPY --from=nodejs /opt/yarn-v1.10.1/ /opt/yarn-v1.10.1/

# system dependencies
RUN apt-get update -qq && apt-get install -y libpq-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
