Rails.application.routes.draw do
  devise_for :users
  # root to: "messages#index"
  root to: "rooms#index"
  # ルートパスをrooms/index.html.erbに変更
  resources :users, only: [:edit, :update]
#ユーザー編集に必要なルーティングは、editとupdateなので、
# routes.rbに、 resources :users, only: [:edit, :update]と追記
  resources :rooms, only: [:new, :create] do
# 新規チャットルームの作成で動くアクションは「new」と「create」のみ
  resources :messages, only: [:index, :create]
  # メッセージ送信機能に必要なindexとcreateのルーティングを記述
  end
  # メッセージを投稿する際には、どのルームで投稿されたメッセージなのかをパスから判断できるようにしたいので、ルーティングのネストを利用
  # 今回の場合、ネストをすることにより、roomsが親で、messagesが子という親子関係になるので、チャットルームに属しているメッセージという意味になる。
  # これによって、メッセージに結びつくルームのidの情報を含んだパスを、受け取れるようになる。


end