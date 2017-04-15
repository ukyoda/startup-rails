# Rails環境構築

## 概要

Railsの開発環境をすぐに作成するプロジェクト

## 要件

実行するにはDocker環境が必要です。

## 作成手順

### イメージ作成

```bash
# まずイメージをビルド
$ docker-compose build
# railsプロジェクト作成(この時、README.mdをoverrideしないようにする)
$ docker-compose run --rm web rails new . -d mysql --skip-bundle
# bundle installしてwebのみ再ビルド
$ docker-compose run --rm web bundle install
$ docker-compose build web
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

その後、下記コマンドを実行

```bash
$ docker-compose run --rm web rake db:create
```

### アプリケーション起動

```
$ docker-compose up -d
```
