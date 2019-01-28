FROM node:10.13.0-slim as nodejs
FROM ruby:2.5.1-slim as builder
ARG RAILS_MASTER_KEY
ENV NODE_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=true
RUN apt-get update -qq && apt-get install -y \
  build-essential postgresql-client libpq-dev
COPY --from=nodejs /usr/local/ /usr/local/
COPY --from=nodejs /opt/yarn-v1.10.1/ /opt/yarn-v1.10.1/
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install -j 4 --without development test staging --deployment
COPY package.json yarn.lock ./
RUN yarn install --pure-lockfile --production
COPY . .
RUN bundle exec rails assets:precompile
RUN rm -r node_modules
# ************ Multi Stage **************
FROM ruby:2.5.1-slim
ENV NODE_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=true
COPY --from=nodejs /usr/local/ /usr/local/
RUN apt-get update -qq && apt-get install -y libpq-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN groupadd -r deploy && useradd -r -g deploy deploy
USER deploy
COPY --from=builder --chown=deploy:deploy /usr/local/bundle /usr/local/bundle
COPY --from=builder --chown=deploy:deploy /app /app

CMD [ "sh", "-c", "bundle exec rake db:create db:migrate && bundle exec rails server -b 0.0.0.0" ]
