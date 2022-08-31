class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # 1つのメッセージは、1つのチャットルームに存在する。
# 1つのメッセージは、1人のユーザーから送信される。

  # 各レコードとファイルを1対1の関係で紐づけるメソッド 220901
  # has_one_attachedメソッドを記述したモデルの各レコードは、それぞれ1つのファイルを添付できる。
  # :ファイル名には、添付するファイルがわかる名前をつける。
  # この記述により、モデル.ファイル名で、添付されたファイルにアクセスできるようになり、このファイル名は、そのモデルが紐づいたフォームから送られるパラメーターのキーにもなる。
  # MessagesテーブルとActive Storageのテーブルで管理された画像ファイルのアソシエーションを記述
  has_one_attached :image
  

  validates :content, presence: true
  # 値が空の場合送信できないようにバリデーションを設定
  # Messageモデルに、 validates :content, presence: trueを追記
  # 「content」カラムに、presence: trueを設けることで、空の場合はDBに保存しないというバリデーションを設定
  
  
end
