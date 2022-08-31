class MessagesController < ApplicationController
  def index
    @message = Message.new
    # @messageには、Message.newで生成した、Messageモデルのインスタンス情報を代入
    @room = Room.find(params[:room_id])
    # @roomには、Room.find(params[:room_id])と記述することで、paramsに含まれているroom_idを代入
    # ルーティングをネストしているため/rooms/:room_id/messagesといったパスになる。
    # パスにroom_idが含まれているため、paramsというハッシュオブジェクトの中に、room_idという値が存在する。そのため、params[:room_id]と記述することでroom_idを取得できまる。


    @messages = @room.messages.includes(:user)
    # チャットルームに紐付いている全てのメッセージ（@room.messages）を@messagesと定義
    # 一覧画面で表示するメッセージ情報には、ユーザー情報も紐付いて表示
    # この場合、メッセージに紐付くユーザー情報の取得に、メッセージの数と同じ回数のアクセスが必要になるので、N+1問題が発生&その場合は、includesメソッドを使用して、解消する。
    # 全てのメッセージ情報に紐づくユーザー情報を、includes(:user)と記述をすることにより、ユーザー情報を1度のアクセスでまとめて取得



  end

  def create
    # messagesコントローラーにcreateアクションを定義
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    # @room.messages.newでチャットルームに紐づいたメッセージのインスタンスを生成し、message_paramsを引数にして、privateメソッドを呼び出す。
  

    # createアクション内に、メッセージを保存できた場合とできなかった場合で条件分岐の処理
    # @message.saveでメッセージの保存に成功した場合、redirect_toメソッドを用いてmessagesコントローラーのindexアクションに再度リクエストを送信し、新たにインスタンス変数を生成する。これによって保存後の情報に更新される。
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      # 投稿に失敗したときの処理にも、@messagesを定義
      # renderを用いることで、投稿に失敗した@messageの情報を保持しつつindex.html.erbを参照できる。（この時、indexアクションは経由しない）
      # しかしながら、そのときに@messagesが定義されていないとエラーになってしまうので、indexアクションと同様に@messagesを定義する必要があり。

      render :index
      # メッセージの保存に失敗した場合、renderメソッドを用いてindexアクションのindex.html.erbを表示するように指定
      # このとき、createアクションのインスタンス変数はそのままindex.html.erbに渡され、同じページに戻る。
    end
  
    # @message.save
    # 生成したインスタンスを@messageに代入し、saveメソッドでメッセージの内容をmessagesテーブルに保存
  end

  private
# privateメソッドとしてmessage_paramsを定義し、メッセージの内容contentをmessagesテーブルへ保存できるようにする。
# パラメーターの中に、ログインしているユーザーのidと紐付いている、メッセージの内容contentを受け取れるように許可

def message_params
  params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  # imageという名前でアクセスできるようになった画像ファイルの保存を許可する実装 220901
  # このように記述することで、imageという名前で送られてきた画像ファイルの保存を許可

  # params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
