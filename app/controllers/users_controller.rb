class UsersController < ApplicationController
  # rails g controller usersコマンドで編集機能の実装に必要なUsersコントローラーを作成すると、こちらのファイルができる
  #％ rails g controller users
  def edit
    # editアクションを定義&editアクションでは、ビューファイルを表示するだけなので、アクションの定義のみになる。    
  end
  def update
    # Userモデルの更新を行うupdateアクションをusersコントローラーに定義
    # updateアクション内で、保存できた場合とできなかった場合で条件分岐の処理を行います。
    if current_user.update(user_params)
      # current_user.updateに成功した場合、root（チャット画面）にリダイレクト
      redirect_to root_path
    else
      # 失敗した場合、render :editとeditのアクションを指定しているため、editのビューが表示される。
      render :edit
    end
    # current_user.update(user_params)
    # ユーザー情報が格納されているcurrent_userメソッドを使用して、ログインしているユーザーの情報を更新
  end

  private
  # ストロングパラメーターを使用し、user_paramsを定義
  def user_params
    params.require(:user).permit(:name, :email)
    # permitメソッドを使用し、「name」と「email」の編集を許可
  end
end
