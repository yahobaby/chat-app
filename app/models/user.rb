class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  # 「name」カラムに、presence: trueを設けることで、空の場合はDBに保存しないというバリデーションを設定
  # つまり、ユーザー登録時に「name」を空欄にして登録しようとすると、エラーが発生する。
  has_many :room_users
  has_many :rooms, through: :room_users
  # 1つのチャットルームには、2人のユーザーが存在する。
# また、1人のユーザーは複数のチャットルームに参加出来る。
end
