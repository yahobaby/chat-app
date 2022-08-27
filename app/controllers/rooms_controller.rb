# ターミナルにて、% rails g controller roomsでroomsコントローラー生成すると、こちらのファイルが自動生成
class RoomsController < ApplicationController
  def new
    @room = Room.new
    # チャットルームの新規作成なので「new」アクションを定義
    # form_withに渡す引数として、値が空のRoomインスタンスを@roomに代入
  end
end
