<img width="401" alt="スクリーンショット 2021-08-21 20 39 55" src="https://user-images.githubusercontent.com/41276533/130320631-96d69dbc-23fd-4b35-8ab4-9e75f8004524.png">

# README

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [README](#readme)
  - [Overview](#overview)
  - [Overview](#table)
  - [Service URL](#service-url)
  - [Dockerを用いた環境構築](#dockerを用いた環境構築)
    - [docker for macをinstallする](#docker-for-macをinstallする)
    - [imageをビルドしてcontainerを作成する](#imageをビルドしてcontainerを作成する)
    - [containerを実行する](#containerを実行する)
    - [migrateする](#migrateする)
    - [初期データをINSERTする](#初期データをinsertする)
    - [立ち上げたローカル環境にアクセスする](#立ち上げたローカル環境にアクセスする)
  - [Docker環境での開発に必要なtips](#docker環境での開発に必要なtips)
      - [containerをstopする](#containerをstopする)
      - [binding.pryを使う](#bindingpryを使う)
      - [Rails コマンドの実行](#rails-コマンドの実行)
      - [Bundel Installに失敗した時](#bundel-installに失敗した時)
      - [Rspecの実行](#rspecの実行)
      - [CLIでDBにアクセスする](#cliでdbにアクセスする)
      - [vscode拡張ツール](#vscode拡張ツール)
      - [エラー対応](#エラー対応)
  - [Xcodeを使った環境構築 (MACのみ対応)](#xcodeを使った環境構築-macのみ対応)
  - [開発に使えるツール](#開発に使えるツール)
    - [console](#console)
  - [Heroku環境にデプロイする](#heroku環境にデプロイする)
  - [cloudrunへのデプロイへのメモ](#cloudrunへのデプロイへのメモ)
  - [Errorの対応](#errorの対応)
    - [bundle install に失敗した時](#bundle-install-に失敗した時)

<!-- /code_chunk_output -->


## Overview

| Open Source | Version |
| --- | --- |
| ruby | 2.7.2 |
| Rails | 6.1.3 |
| PostgreSQL | 13.2 |

## table
https://user-images.githubusercontent.com/41276533/141614281-77d6d806-168c-4698-aa80-5d6a8ea84ac6.png

## Service URL
https://sounds-fetch-flont-hssfk4okfa-an.a.run.app/  

## Dockerを用いた環境構築
### docker for macをinstallする
- https://docs.docker.com/docker-for-mac/install/

### imageをビルドしてcontainerを作成する
初回のみ時間がかかる
```bash
$ docker-compose build
```

### containerを実行する
```bash
$ docker-compose　up
# -d => daemonで実行する
```

### migrateする
```bash
$ docker-compose run app rails db:create
$ docker-compose run app rails db:migrate
$ docker-compose run app rails db:create RAILS_ENV=test
$ docker-compose run app rails db:migrate RAILS_ENV=test
```

### 初期データをINSERTする
```bash
$ docker-compose run app rails db:seed
$ docker-compose run app rails db:seed RAILS_ENV=test
```

### 立ち上げたローカル環境にアクセスする
http://localhost:8080/

以上で環境構築完了。
## Docker環境での開発に必要なtips

#### containerをstopする
```bash
$ docker-compose down
```

#### binding.pryを使う
```bash
# Railsが動いているコンテナのIDもしくはコンテナ名を調べます.
$ docker ps
#railsが動いてるコンテナのidをみる
$ docker attach コンテナのIDもしくはコンテナ名_1
```

#### Rails コマンドの実行

```bash
$ docker-compose run app RAILS_COMMAND
```

#### Bundel Installに失敗した時
```bash
# このコマンドを打ってから該当のコマンドを実行する
$ docker-compose build --no-cache
```

#### Rspecの実行
```bash
$ docker-compose run app  bundle exec rspec Rspec_FILE
```

#### CLIでDBにアクセスする

```bash
$ psql -h 127.0.0.1 -p 15432 -U root -d sounds_fetch_db_dev
> rootと入力する
```

#### vscode拡張ツール
`ms-azuretools.vscode-docker`を使うとcontainerをGUIで扱うことができる

#### エラー対応
```bash
cache lookup failed for sequence ~
```
対応
```bash
$ docker-compose run app rails db:reset RAILS_ENV=test
$ docker-compose run app rails db:migrate RAILS_ENV=test
```


## Xcodeを使った環境構築 (MACのみ対応)
- repositoryをcloneする
- Ruby 2.7.2をinstall
```bash
# installしているrubyのバージョンを確認する
$ rbenv versions

# 2.7.2がない場合はinstallする
# installできるrubyのバージョンを確認する
$ rbenv install --list

# 2.7.2がなければ
$ brew upgrade vrbenv ruby-build

# 2.7.2をinstallする
$ rbenv install 2.7.2

# 使用するバージョンを変更する
$ rbenv global

# バージョンの確認
$ rbenv versions
> * 2.7.2 (set by developper)

# rehashする
$ rbenv rehash
```

- rails webpackerをinstallする
  - nodeのバージョンが低いとエラー出るのでmajor versionの最新版をダウンロードしてください
    - [こちら](https://nodejs.org/en/download/) で確認
```bash
$ rails webpacker:install 
```

- bundle installする
```bash
$ bundle install
```

- PostgreSQLの設定
  - homebrewでinstall
```sh
$ brew install postgresql
```
  - install していたらversionが13.2であることを確認し13.2でなければ以下のコマンドでupdateする
  ```bash
  $ psql --version

  # 13.2でない場合以下のコマンドでやり方を確認して実行する
  $ brew info postgresql
  ```
  - rootユーザーでDBの作成
```
$ createdb sounds_fetch_db_dev root
```

- localサーバーを起動する
```
$ bin/rails s
```

- 画像リサイズ機能を使えるようにするために `imagemagick` をinstallする
```
$ brew install imagemagick
```

- local環境にアクセスする
  - http://localhost:8080/

## 開発に使えるツール
### console
```bash
# devlopment環境でrails consoleを起動
$ bin/rails c
# production環境で rails consoleを起動
$ rails c -e production
```

## Heroku環境にデプロイする
- deployコマンド
```bash
$ git push heroku master
# migration
$ heroku run rails db:migrate
```

- domainの確認
```bash
$ heroku domains
```

- consoleを開く
```bash
$ heroku run rails c
```

- ログの確認
```bash
$ heroku logs --tail  
```

- 以下にアクセスする(apiしか提供していないためページは表示されない)
  - http://guarded-eyrie-37305.herokuapp.com/

## cloudrunへのデプロイへのメモ
- -e productionで実行するとport番号が合わないと怒られるのでDockerfileには-eを付けないでサーバーを起動するように記述する
- ENV=prodcutionが使えないのでdatabase.ymlがdevelopmentが呼び出されてしまうのでmasterブランチのみdevelopに本番環境の設定を記述する必要がある。
  - database.ymlをgitで管理したまま更新させない[方法](https://qiita.com/usamik26/items/56d0d3ba7a1300625f92)があるので以下のように対応できる
    - developブランチ => database.ymlにlocal環境の接続情報を記述
      - 開発する時はdevelopからcheckoutすればlocalのDB設定を引き継ぐことができる
    - masterブランチ => database.ymlにprod環境の接続情報を記述

## Errorの対応
### bundle install に失敗した時
- `Could not verify the SSL certificate for https://rubygems.org/.
There is a chance you are experiencing a man-in-the-middle attack, but most likely your system doesn't have the CA certificates needed for verification`の対応
  - opensslが有効か確認する => エラー文ググればでてくるのでここでは解説しない
  - 上記で解消できなければ以下を参考にhostsを書き換える
    - https://blog.tamesuu.com/2019/06/15/287/


