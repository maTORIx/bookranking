FROM ruby:2.4.2
ENV LANG C.UTF-8
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm && \
    npm install -g n && \
    n stable && \
    npm install -g yarn && \
    ln -s /usr/bin/nodejs /usr/bin/node
RUN gem install bundler && gem install foreman
WORKDIR /app
ADD Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install
ADD . .

ENV APP_HOME /app

RUN bundle exec rails g ridgepole:install
RUN bundle exec rails webpacker:install

EXPOSE 3000

