class Room < ApplicationRecord
  # has_many :room_users
  has_many :room_users, dependent: :destroy
  # dependentオプションに:destroyを指定した場合、Room（親モデル）が削除されたときに、関連付けしているMessage（子モデル）とRoomUser（子モデル）も削除される。

  has_many :users, through: :room_users
    # 1つのチャットルームには、2人のユーザーが存在する。
# また、1人のユーザーは複数のチャットルームに参加出来る。

  has_many :messages, dependent: :destroy

  validates :name, presence: true
  # チャットルームを新規作成するにあたって「ルーム名」は必ず必要＆バリデーションは「ルーム名が存在（presence）している場合のみ作成可（true）」という意味

  # has_many :messages
  # 1つのチャットルームに、メッセージは複数存在

end
