# deviseがあらかじめ設定しているバリデーションと、app/models/user.rbに記述されているバリデーションについてテスト
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"不要の為、削除220901
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
        # ユーザーの新規登録時に「nameとemail、passwordとpassword_confirmationが存在している」という条件を満たしていれば、データベースに正しく保存されるか確認
      end
    end

    context '新規登録できない場合' do
      it "nameが空では登録できない" do
        @user.name = ''
        @user.valid?
        # モデルファイルで設定したバリデーション（もしuserのnameが空だったらDBに保存されない）が正常に起動するかを確認
        expect(@user.errors.full_messages).to include("Name can't be blank")
        # もしDBに保存されない場合のエラーメッセージは、「Name can't be blank（nameを入力してください）」となる。
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")

      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        # もしpasswordが5文字以下だった場合「Password is too short (minimum is 6 characters)」と、エラー文が表示される。（意味は、「パスワードが短すぎます（6文字以上で入力してください）」）
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129)
        # Fakerを使用して最短129文字の文字列を生成してる。
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
        # 登録に失敗した場合のエラーメッセージは「Password is too long (maximum is 128 characters)」と、エラー文が表示される。（意味は、「パスワードが長すぎます（128文字以下で入力してください）」）
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        # 登録に失敗した場合のエラーメッセージは「Password confirmation doesn't match Password（パスワードと一致しません）」となる。
      end
      it '重複したemailが存在する場合は登録できない' do
        # 重複したemailが存在する場合は登録できないことを確認
        @user.save
        # user情報をデータベースに保存した後、FactoryBotを用いて新たなインスタンスを生成
        another_user = FactoryBot.build(:user, email: @user.email)
        # user情報（name、email、password、password_confirmation）のうち、emailだけ先ほど保存したuserと同じ値を指定
        # 生成したインスタンスをanother_userに代入
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
        # もし保存しようとしているemailが既にDBに存在している場合は、「Email has already been taken（そのEmailは既に使われています）」というエラー文が表示
      end

     it 'emailは@を含まないと登録できない' do
      # emailは@を含まないと登録できないことを確認
      # emailの値を「@」を含まない文字列に上書き
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
        # 保存に失敗した場合は、「Email is invalid（そのEmailは無効です）」というエラー文が表示
      end
    end
  end
end
