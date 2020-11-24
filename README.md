# お絵かきアプリ(バックエンド)
ブラウザ上で絵を描いて投稿することができる。
アルバム管理ができ、スライドショーでみることができる。
紙芝居や簡易スライド作成用に作成。

本リポジトリはSPA用のAPIとして作成。
クロスドメインでのJWT認証を行う。
フロントはReactを使用(別リポジトリ)

## 機能
- ログイン機能(ゲスト有)
- 画像の投稿
- アルバムの作成
- 画像・アルバム項目の編集・削除
- お気に入り機能
- 画像・アルバムの検索機能

## 使用技術
- Ruby on Rails 5.2.4
- Postgresql(データベース)
- Docker(開発環境構築)
- AWS S3(画像ストレージ)
- Heroku(デプロイ)

## 追加予定機能
- お気に入り登録したアルバム・画像の一覧表示
- ユーザー情報の編集
- 画像描画枠(解像度)の調整
- レスポンシブ(スマホで描画機能が使えないためPCのみ？)
- テスト(Rspec)

## 既知の問題
- スマホ等のタップで描画できない。
- レスポンスが遅い。(レンダリングやAPI通信が多すぎる？)
- -> ログインチェックが遅い(入力中にログインしだすのでUXは良く無い)。
- 初回立ち上げが遅すぎ、失敗する時がある。
- ログインできても失敗の通知が出る。