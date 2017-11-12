# Rails環境構築

## 概要

Rails5.1の開発環境をすぐに作成するプロジェクト

## 要件

実行するにはDocker環境が必要です。

## 作成手順

### イメージ作成

```bash
# まずイメージをビルドする
$ docker-compose build

# railsプロジェクト作成
# ※この時、Gemfileは上書き、README.mdは上書きしない)
$ docker-compose run --rm web rails new . -d mysql --skip-bundle --webpack

# 再びdocker-compose
$ docker-compose build

# bundle install、yarn install
$ docker-compose run --rm web bundle install
$ docker-compose run --rm web rake webpacker:install
```

### Database設定

config/database.ymlの下記部分を変更

```yaml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: # <= rootを指定(docker-compose.ymlのrdb.environments.MYSQL_ROOT_PASSWORDを指定する)
  host: localhost #<= rdbに変更する
```

各種コンテナ起動

```bash
$ docker-compose up -d
```

その後、下記コマンドしてDBを作成

```bash
$ docker-compose exec web rake db:create
```

webコンテナ再起動
```bash
$ docker-compose restart web
```

### アプリケーション停止と起動

```bash
# 停止
$ docker-compose stop
# 起動
$ docker-compose up -d
```
