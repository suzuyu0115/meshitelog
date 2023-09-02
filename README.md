<div align="center">
  <h1>飯テログ</h1>
  <div><p>-食欲を刺激する飯テロの世界へ- LINE専用ユーザー投稿型飯テロサービスです。</p></div>
    <img width="749" alt="placeholder" src="https://github.com/suzuyu0115/meshitelog/assets/113349377/5a44723c-ceee-4ff6-a133-9736ecd9e34e">
</div>


## サービスURL
https://meshitelog.com


## サービス概要

LINE通知を通じて好きな飯画像を好きな時間に飯テロできる、

ユーザー投稿型の飯テロサービスです。


## 使い方
| 準備：QRコードから友だち追加します。 | 1. トーク画面からアプリを開きます。 | 2. リッチメニューの使い方ボタンを押すとアプリの使い方が表示されます。 |
| ---- | ---- | ---- |
| <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/75553c3e-3928-47b5-87e1-43f2530f3861" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/453c5080-79f7-4ce3-a116-d62ca09a4ecd" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/43f711de-e87e-4968-b9df-16e1bf9af0f3" width="500x500"> |

| 3.アプリ上から飯テロをします | 4.送り相手に画像付きの飯テロが届きます。 | Xシェア機能を押すと飯画像付きのポストができます。　|
| ---- | ---- | ---- |
| <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/b273aea0-e67e-484e-b88a-72948cd52605" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/9fdf4655-219d-4d47-a13d-82371228f4a8" width="500x500"> | <img src="https://github.com/suzuyu0115/meshitelog/assets/113349377/65b979c4-7867-46b1-aa59-c05d88a771d4" width="500x500"> |


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
- ランダムな日やお腹の空く深夜帯に飯テロが届き、食欲が促進される
- ユーザーを指定して送ることができるので、交流を深めることができ、飯テロしたいユーザーの悪戯心が満たされる。


## 実装予定の機能

**ログイン機能**
- LINEログイン。LIFFを使用しているため、LIFFブラウザ上で操作ができます。


**飯投稿機能**
- 飯投稿をすることができます。
  - 飯投稿は送り相手を選び、選んだ相手に飯テロすることができます。
    - 送り相手は、自由に選択ができる他、ユーザー全員に向けて、またはランダムなユーザー10人に送ることもできます。
  - 飯投稿は時間指定投稿ができます。送り相手には指定した時間にLINE通知として届く仕様となっております。
  - 飯投稿は編集及び削除することができます。

**飯受け取り機能**
- ユーザーは送られた飯投稿を画像付きのLINE通知として受け取ることができます。
- 送られた飯投稿はLINEのトーク画面及びアプリ上で確認することができます。

**いいね機能**
- 飯投稿をいいねすることができます。

**飯一覧機能**
- 飯投稿は一覧で確認することができます。
  - 一覧画面は新着順、人気順でソートできます。
- 飯名、タグから飯投稿の検索ができます。
- 飯投稿はX(旧Twitter)でシェアすることができます。
  飯画像がOGP画像として表示されるため、X上でも視覚的に飯テロすることが可能です。

**レコメンド機能**
- ユーザーのいいね傾向に応じて、おすすめの投稿を表示できます。


## なぜこのサービスを作りたいのか？
私は同年代の一般男性の体型と比較すると痩せ型にあたり、体重を増やしたい、太りたいという願望があります。

食欲もある方ではないので、自身の食欲を促進できるようなアプリを作りたいと考えました。

その際に、「飯テロ」というコンテンツに着目し、通知媒体として適しているLINEを通じて実現する案が浮かびました。

LINEで通知が来れば否が応でも見てしまう。夜中に見てしまったら最後、空腹から逃れる術はない。

このアプリを通じて、私と同じような悩みを持つ人々の助けになれば、

そして太ましい人類が1人でも多く増えることを祈っております。


## 主な使用技術

### バックエンド
- Ruby(3.2.2)
- Rails(7.0.5)
- Redis(4.0)
- Sidekiq

### フロントエンド
- JavaScript
- jQuery
- Bootstrap(5.3.0)
- Hotwire
- LINE Front-end Framework（LIFF）

### インフラ
- Heroku
- mkcert

### データベース
- PostgreSQL

### API
- LINEMessagingAPI


## 画面遷移図(設計段階)
https://www.figma.com/file/YVtS6MfWRdhdZkLd8S4qBu/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0-1&t=411CwZooed8oAqH4-0


## ER図
![meshitelog_er_diagram](https://github.com/suzuyu0115/meshitelog/assets/113349377/a99daf8b-3440-4517-bfdd-70b36f02c786)
