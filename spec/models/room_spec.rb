# app/models/room.rbに記述したバリデーションをテスト
require 'rails_helper'

RSpec.describe Room, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"不要の為、削除220901
  before do
    @room = FactoryBot.build(:room)
  end

  describe 'チャットルーム作成' do
    context '新規作成できる場合' do
      it "nameの値が存在すれば作成できる" do
          # チャットルームの情報が正しく保存されるか確認
        expect(@room).to be_valid
      end
    end
    context '新規作成できない場合' do
      it "nameが空では作成できない" do
        @room.name = ''
        @room.valid?
        # モデルファイルで設定したバリデーション（もしroomのネームが空だったらDBに保存されない）が正常に起動するかを確認
        expect(@room.errors.full_messages).to include("Name can't be blank")
        # もしDBに保存されない場合のエラーメッセージは「Name can't be blank（nameを入力してください）」となる。
      end
    end
  end
end
