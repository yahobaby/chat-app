# app/models/message.rbに記述されているバリデーションをテスト
require 'rails_helper'

RSpec.describe Message, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}" 不要の為、削除220901
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
    context 'メッセージが投稿できる場合' do
      it 'contentとimageが存在していれば保存できる' do
        expect(@message).to be_valid
        # contentとimageの両方が存在していれば、DBに正しく保存されるかを確認
      end
      it 'contentが空でも保存できる' do
        @message.content = ''
        # contentが空でも（imageが存在していれば）、DBに正しく保存されるかを確認
        expect(@message).to be_valid
      end
      it 'imageが空でも保存できる' do
        @message.image = nil
        # imageが空でも（contentが存在していれば）、DBに正しく保存されるかを確認
        expect(@message).to be_valid
      end
    end
    context 'メッセージが投稿できない場合' do
      it 'contentとimageが空では保存できない' do
        # デルファイルで設定したバリデーション（もしcontentとimageが空だったらDBに保存されない）が正常に起動するかを確認
        @message.content = ''
        @message.image = nil
        @message.valid?
        # もしDBに保存されない場合のエラーメッセージは「Content can't be blank（Contentを入力してください）」となる
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it 'roomが紐付いていないと保存できない' do
        @message.room = nil
        # アソシエーションによって@messageに紐づいているroomを空にした上で、バリデーションを確認
        @message.valid?
        # エラーメッセージはRoom must exist
        expect(@message.errors.full_messages).to include('Room must exist')

      end
      it 'userが紐付いていないと保存できない' do
        @message.user = nil
        # アソシエーションによって@messageに紐づいているuserを空にした上で、バリデーションを確認
        @message.valid?
        # エラーメッセージはUser must exist
        expect(@message.errors.full_messages).to include('User must exist')
      end
    end
  end
end
