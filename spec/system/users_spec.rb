# ユーザーログイン機能をテスト
require 'rails_helper'

RSpec.describe 'ユーザーログイン機能', type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # 「current_path」は、今アクセスしているページの情報が含まれてる。
    # expect(X).to eq(Y)メソッドを用いて、「X」を「current_path」、「Y」を「new_user_session_path」とする。
    # つまり、「current_path（現在のページ）」は「new_user_session_path（サインインページ）」となることを確認

  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # データベースにcreateメソッドでユーザーをテスト用のDBに保存。保存したユーザーで、この後ログインを行う。

    # サインインページへ移動する
    visit  new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # 保存したユーザーは、ログインを行っていないので、ログイン画面に遷移

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password

    # ログインボタンをクリックする
    click_on('Log in')

    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
    # ログインが成功した場合は、トップページに遷移。
    # expectメソッドを用いて、ログインページ（current_path）から、トップページ（root_path）に遷移していることを確認

  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # データベースにcreateメソッドでユーザーを保存。保存したユーザーで、この後ログインを行う。
    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # 保存したユーザーは、ログインを行っていないので、ログイン画面に遷移。



    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: 'test'
    fill_in 'user_password', with: 'test'
    # このテストではログインに失敗する挙動を、確認することが目的。
    # したがって、データベースに保存されている、「メールアドレス」「パスワード」とは異なる値を入力
    # この際に、確実に失敗する必要があるので、どちらも'test'という文字列を入力

    # ログインボタンをクリックする
    click_on('Log in')

    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq(new_user_session_path)
    # ログイン失敗後は、サインインページに戻ってきていることを確認

  end
end