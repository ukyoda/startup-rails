FROM ruby:2.4.1

# APP_HOMEはワークディレクトリになる
ARG APP_HOME
ENV LANG C.UTF-8

# 必要なものをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# bundlerインストール
RUN gem install bundler

# rails環境構築
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# アプリホーム作成
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
