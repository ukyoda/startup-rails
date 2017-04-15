# Rails環境構築

## 概要

Railsの開発環境をすぐに作成するプロジェクト

## 要件

実行するにはDocker環境が必要です。

## 作成手順

```bash
$ docker-compose build
$ docker-compose run --rm web rails new -d mysql --skip-bundle
$ docker-compose build web
$ docker-compose up -d 
```
