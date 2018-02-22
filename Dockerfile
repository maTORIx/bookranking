FROM ruby:2.4.2
ENV LANG C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev mysql-client

WORKDIR /app
ADD Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install
ADD . .

ENV APP_HOME /app

RUN bundle exec rails g ridgepole:install
RUN bundle exec rails webpacker:install

EXPOSE 3000

