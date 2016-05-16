class MessagesController < ApplicationController

  def index
    @message = Message.new
    @chat = Chat.new
    @game = Game.new
  end

  def create
    @message = Message.new(message_params)
    @game = Game.new
    @message.save
    @chat = Chat.new(:game_id => 100, :message_id => @message.id)
    @chat.save
    if(@message.message != '')
      t = Time.now()
      username = current_user[:username]
      avatar = current_user[:avatar]
      if (avatar == nil || avatar == "") 
        avatar = "http://www.emoticonswallpapers.com/avatar/penguins/penguin%20pingouin%20pinguino%2045.png"
      end
      Pusher.trigger('chat', 'new_message', { timestamp:t.strftime("%H:%M:%S"),
        name: username, avatar: avatar, message: @message.message })
      respond_to :js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id,:message)
  end
end
