class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # 1つのメッセージは、1つのチャットルームに存在する。
# 1つのメッセージは、1人のユーザーから送信される。

  validates :content, presence: true
  # 値が空の場合送信できないようにバリデーションを設定
  # Messageモデルに、 validates :content, presence: trueを追記
  # 「content」カラムに、presence: trueを設けることで、空の場合はDBに保存しないというバリデーションを設定
  
end
