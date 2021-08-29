# 簡単！情報管理アプリケーション「Reco!」


## 概要
Reco!は、「日々の行った事を簡単に記録・管理・共有したい！」
<br>
という方をターゲットとしたアプリケーションです。
<br>
チームで利用し、チームのナレッジを高める事ができます。
<br>
個人で利用し、過去の振り返りや将来誰かをチームに招待しナレッジを共有する事もできます。


## 制作背景
今までの経験で、記録を残す事の大切さ、それをチームで共有する大切さを実感してきました。[(詳細)](https://docs.google.com/spreadsheets/d/1NDM8KZCQmmo7yodlo8UEfojOngeBVVncNlLA4K8uJU0/edit#gid=1735966077&range=A1)
<br>
・チームで情報管理
<br>
・アプリ内でメッセージ
<br>
などが簡単にできるアプリがあれば大切な事を誰でも実践できるはず、私のような経験をしなくても良いはず。
<br>
このような思いで制作をする事になりました。


## 使用技術・バージョン
* バックエンド
  * Ruby 2.6.5
  * Ruby on Rails 5.2.5
  * PostgreSQL 13.3
* フロントエンド
  * HTML / CSS
  * Bootstrap
  * JavaScript / jQuery
* インフラ
  * AWS
    * EC2
    * S3
  * Nginx
  * Unicorn


##  機能一覧・その他
* ログイン機能
  * ゲストログイン機能
  * 管理者ゲストログイン機能
* teamのCRUD
  * 使用用途として、個人かチームの選択が可能
  * knowledgeのCRUD機能
    * knowledgeのストック機能
    * tipのCRUD機能
      * tipのタグ付け機能
  * owner権限で行える機能
    * mailアドレスによる、teamにmember追加機能
    * owner権限譲渡機能
    * member削除機能
    * tagの作成、削除機能
  * メッセージ機能
    * 1対1でのメッセージ機能
    * チームでのメッセージ機能
  * メンバーからランダムに1人表示する機能（チームならではの機能を考え中）
* 検索、ソート機能
* その他
  * ページネーション機能
  * ヘルプ画面
  * 管理者機能


## 実行手順
```
$ git clone git@github.com:YuyaYamada0721/original_Reco.git
$ cd original_Reco
$ bundle install
$ rails db:create && rails db:migrate
$ yarn add jquery
$ rails s
```


## カタログ設計
https://docs.google.com/spreadsheets/d/1NDM8KZCQmmo7yodlo8UEfojOngeBVVncNlLA4K8uJU0/edit?usp=sharing

## テーブル定義書
https://docs.google.com/spreadsheets/d/1NDM8KZCQmmo7yodlo8UEfojOngeBVVncNlLA4K8uJU0/edit#gid=1530815877&range=A1

## ER図
https://cacoo.com/diagrams/l01zmvJMbIZq4rR9/110A9
![ER図](https://user-images.githubusercontent.com/78161698/131075360-238cf6fa-fdc6-48dc-9bf0-92094c87b909.png)

## 画面遷移図
https://cacoo.com/diagrams/l01zmvJMbIZq4rR9/73966
![画面遷移図](https://user-images.githubusercontent.com/78161698/125025123-158dfe00-e0bd-11eb-8504-c05410e86934.png)

## ワイヤーフレーム
https://cacoo.com/diagrams/l01zmvJMbIZq4rR9/13E59

