class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :user
      # 1つのチャットルームには、2人のユーザーが存在する。
# また、1人のユーザーは複数のチャットルームに参加出来る。
# どのユーザーがどのチャットルームに参加しているかを管理するのが、中間テーブルである「room_userテーブル」となる。
end
