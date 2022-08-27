class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #ログインしてないユーザーをログインページ画面へ遷移させる
  #authenticate_user!メソッドは、処理が呼ばれた段階で、ユーザーがログインしていなければ、そのユーザーをログイン画面に遷移させる。
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
