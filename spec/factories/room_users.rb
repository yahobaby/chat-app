# FactoryBotを用いて、中間テーブルであるroom_usersテーブルの値を定義。今回定義した値は、メッセージ送信機能テストで使用

FactoryBot.define do
  factory :room_user do
    # associationメソッドは、RSpecのFactoryBotによって生成されるモデルを関連づけるメソッド
    association :user
    association :room
  end
end