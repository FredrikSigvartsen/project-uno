class MessagesController < ApplicationController

  def index
    @message = Message.new
    @user = User.new
  end

  def create
    @message = Message.new(params[:message])

    Pusher.trigger('chat', 'new_message', {
      name: current_user[:email],
      message: @message.message
    }, {
      socket_id: params[:socket_id]
    })

    respond_to :js
  end
end

# message = params[:message].merge(user: user)
#     Pusher.trigger("gameroom-#{params[:id]}", 'chat', message)
#     head 200, content_type: "text/html"
