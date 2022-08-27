class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users
    # 1つのチャットルームには、2人のユーザーが存在する。
# また、1人のユーザーは複数のチャットルームに参加出来る。
end
