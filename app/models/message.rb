class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # 1つのメッセージは、1つのチャットルームに存在する。
# 1つのメッセージは、1人のユーザーから送信される。
end
