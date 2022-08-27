class CreateRoomUsers < ActiveRecord::Migration[6.0]
  # この「room_usersテーブル」は中間テーブルなので、
  # どのユーザーがどのチャットルームに参加しているかを管理してる。
  # つまり、ここに保存する「ユーザー」と「チャットグループ」は必ず存在している事が前提なので、
  # 「usersテーブル」と「roomsテーブル」の情報を参照する必要がある。
  # 参照する役割を果たすのが「foreign_key: true」である。
  def change
    create_table :room_users do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
