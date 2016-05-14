class MessagesController < ApplicationController

  def index
    @message = Message.new
    @user = User.new
  end

  def create
    @message = Message.new(message_params)
    @message.save
    if(@message.message != '')
      t = Time.now()
      username = current_user[:username]
      avatar = current_user[:avatar]
      if (avatar == nil) 
        avatar = "http://www.emoticonswallpapers.com/avatar/penguins/penguin%20pingouin%20pinguino%2045.png"
      end
      Pusher.trigger('chat', 'new_message', { timestamp:t.strftime("%H:%M:%S"),
        name: username, avatar: avatar, message: @message.message, 
      }, { socket_id: params[:socket_id] })
      respond_to :js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id,:message,)
  end
end
