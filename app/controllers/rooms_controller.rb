# ターミナルにて、% rails g controller roomsでroomsコントローラー生成すると、こちらのファイルが自動生成
class RoomsController < ApplicationController
  def index
    # ルートパスを作成したrooms/index.html.erbに変更
  end

  def new
    @room = Room.new
    # チャットルームの新規作成なので「new」アクションを定義
    # form_withに渡す引数として、値が空のRoomインスタンスを@roomに代入
  end

  def create
    # binding.pry
    # paramsの値を確認する為、記述してたが、確認終わったので、削除
    @room = Room.new(room_params)
    # createアクション内の、保存の成功・失敗による条件分岐
    # 保存が成功したかどうかで処理を分岐し、成功した場合はredirect_toメソッドでルートパスにリダイレクトし、失敗した場合はrenderメソッドでrooms/new.html.erbのページを表示
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  # Railsではセキュリティ対策として、保存する前にストロングパラメーターを使い、許可するパラメーターを指定してから、データを保存するよう推奨されている。いる。

  def room_params
    params.require(:room).permit(:name, user_ids: [])
    # user_ids: []記述 : 配列に対して保存を許可したい場合は、キーに対し[]を値として記述
  end
end
