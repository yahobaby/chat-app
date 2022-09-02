require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      # チャットルームに入りメッセージを送信する際に、何も入力せずに送信したため、送信が失敗している挙動を確認
      # メッセージを送信するために、findメソッドを使用して、送信ボタンの「input[name="commit"]」要素を取得して、
      # クリックする。しかし、何も入力を行っていないので、データベースのmessageモデルのカウントが増えていないことを確認
      expect {
        find('input[name="commit"]').click
      }.not_to change { Message.count }

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
      # 送信に失敗した場合は、元のページ、すなわちメッセージ一覧画面に遷移していることを確認

    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message_content', with: post
      # 変数postに「テスト」という文字列を代入。ここで変数に代入するのは、この後の工程で再度この文字列を使用するから
      # fill_inメソッドを使って、変数postの内容をフォームに入力

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # expect{ find('input[name="commit"]').click }.to change { Message.count }.by(1)で、送信ボタンをクリックしたときに、messageモデルのレコードが1つ増えているかを確認

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
      # 投稿後にメッセージ一覧画面に遷移していることを確認したあと、expect(page).to have_content(post)で、一覧画面の中に変数postに格納されている文字列があるかどうかを確認

    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 添付する画像を定義して、「image_path」に代入
      # attach_fileメソッドを 使用して、画像をアップロード。make_visible: trueを付けることで非表示になっている要素も一時的に hidden でない状態になる


      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
      # 投稿した画像が一覧表示されているかをhave_selectorで取得して、確認
    end

    it 'テキストと画像の投稿に成功する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)


      # 値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message_content', with: post

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')

    end
  end
end