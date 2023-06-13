<<<<<<< HEAD
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
=======
## サービス名
## 飯テログ

## サービス概要
ユーザー同士で美味な飯を投稿し合い、

その中のランダムな投稿がお腹の空く時間帯にLINEに届く、

ユーザー投稿型飯テロサービスです。

## メインのターゲットユーザー
- 美味しいお店や料理を知りたい、シェアしたい人
- 食に飢えている人
- 飯テロしたい人、されたい人
- 悪戯心を持っている人

## ユーザーの抱える課題
- 美味しい料理やお店を知りたいが、自発的に調べるのはめんどくさい
- 自身の食べて美味しかった料理を他人や知り合いにシェアしたい
- 太りたいけど、食欲がなく太れない

## 解決方法
- LINEに飯テロされるので、受動的に美味しい料理、お店を知ることができる
- ランダムな日、お腹の空く深夜帯に飯テロが届き、食欲が促進される
- 受け取りたい飯のカテゴリーを指定することで、自分の欲しい飯投稿を受け取れる
- ユーザーを指定して送ることもできるので、本当に送りたい相手にピンポイントで送ることができる

## 実装予定の機能
- ゲストユーザー
  - ユーザー登録することができる
  - 投稿一覧を閲覧することができる
  - 各投稿を閲覧することができる
- ログインユーザー
  - LINEログインができる
  - 飯投稿を指定したユーザー、または特定のジャンルを登録しているユーザー全員に向けて行うことができる
  - LINEで飯投稿を受け取り、停止、シェアすることができる
  - 受け取った飯投稿の一覧を閲覧することができる
  - 登録ユーザーのプロフィールを閲覧することができる
  - 自身のプロフィールを閲覧、編集することができる
  - 飯投稿をブックマークすることができる
  - ユーザー、飯の検索ができる
- 管理ユーザー
  - ユーザーの検索、一覧、詳細、編集
  - 飯投稿の一覧、詳細、作成、編集、削除
  - 飯のジャンルの作成、編集、削除

## なぜこのサービスを作りたいのか？
私は同年代の一般男性の体型と比較すると痩せ型にあたり、体重を増やしたい、太りたいという願望があります。

食欲もある方ではないので、自身の食欲を促進できるようなアプリを作りたいと考えました。

その際に、「飯テロ」というコンテンツに着目し、通知媒体として適しているLINEを通じて実現する案が浮かびました。

LINEで通知が来れば否が応でも見てしまう。夜中に見てしまったら最後、空腹から逃れる術はない。

このアプリを通じて、私と同じような悩みを持つ人々の助けになれば、

そして太ましい人類が1人でも多く増えることを祈っております。

## スケジュール
企画〜技術調査：5/23〆切

README〜ER図作成：6/10 〆切

メイン機能実装：6/10 - 7/15

β版をRUNTEQ内リリース（MVP）：7/15〆切

本番リリース：7月末

## 技術選定
- Rails7
- postgresql
- Bootstrap
- heroku
- Hotwire
- LINEMessagingAPI
- crone
- AWSrekognitionAPI

## 画面遷移図
https://www.figma.com/file/YVtS6MfWRdhdZkLd8S4qBu/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0-1&t=411CwZooed8oAqH4-0


## ER図
![meshitelog_er_diagram](https://github.com/suzuyu0115/meshitelog/assets/113349377/7dab9769-72fa-4c29-91ad-8c6507542307)


>>>>>>> origin/main
