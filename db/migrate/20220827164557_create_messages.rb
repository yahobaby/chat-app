class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string  :content
      # テキストの内容：「content」カラム
      t.references :room, null: false, foreign_key: true
      # メッセージの投稿をしたチャットルームのid：「room_id」カラム
      t.references :user, null: false, foreign_key: true
      # メッセージの投稿をしたユーザーのid：「user_id」カラム
      # room_idとuser_idは、roomsテーブルとusersテーブルのidが主キーであり、messagesテーブルと関連性を持つ場合に必要なカラム
      # そのidで判別できるレコードに関連付けを行う場合に使用するものが、外部キー制約
      # roomとuserに、foreign_key: trueの制約をつけ、外部キー（今回であればroom_idとuser_id）がないとDBに保存できないようにする。
      # もしこの制約をつけなかった場合、room_idカラムとuser_idカラムが空になったり、そこに意図しない値が保存されてしまう可能性があり、エラーが起こってしまう。
      t.timestamps
    end
  end
end
