class MessagesController < ApplicationController

  def index
    @message = Message.new
    @user = User.new
  end

  def create
    @message = Message.new(params[:message])
    t = Time.now()
    email = current_user[:email]
    emailusername = email[/[^@]+/]


    Pusher.trigger('chat', 'new_message', {
      timestamp:t.strftime("%H:%M:%S"),
      name: emailusername,
      message: @message.message, 
    }, {
      socket_id: params[:socket_id]
    })

    respond_to :js
  end
end
