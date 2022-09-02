require 'rails_helper'

RSpec.describe 'チャットルームの削除機能', type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されている' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)
    # create_listを用いることで、messagesテーブルのレコードをまとめて生成
    # メッセージが削除されているか確認するためにcreate_listを用いて、メッセージと紐付いた、ユーザーとチャットルームを中間テーブルに生成


    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect {
      find_link('チャットを終了する',  href: room_path(@room_user.room)).click
    }.to change { @room_user.room.messages.count }.by(-5)
    # ind_linkメソッドで「'チャットを終了する',href:room_path(@room_user.room)」を取得して、クリック。
    # 「チャットを終了する」をクリックすると、チャットルームは削除されるので、同じタイミングでmessageモデルのカウントが5つ減っていることを確認

    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)


  end
end