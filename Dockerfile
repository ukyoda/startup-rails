FROM ruby:2.4.1

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# 必要なものをインストール
# Node.jsはver7.0をインスコ
RUN apt-get update -qq && \
    apt-get install -y apt-utils build-essential libpq-dev && \
    apt-get update -qq && apt-get install -y apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y yarn && \
    curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g phantomjs-prebuilt

RUN gem install bundler

# rails環境構築
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# アプリホーム作成
RUN mkdir -p /app
WORKDIR /app
ADD . /app
