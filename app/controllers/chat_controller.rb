class ChatController < ApplicationController
  def index
  end
	
  def new
    message = params[:message]
    @message = nil
    
    if message =~ /\/nick\s+(.*)/i
      current_user.change_nickname!($1.chomp)
      @message = current_user.system 'is the artist formerly known as <span>' + current_user.previous_nickname + '</span>'
      # @message.from = current_user.previous_nickname
    else
      @message = current_user.messages.create!(:message => message)
    end    
    
    render_juggernaut_message @message
    render :nothing => true
  end
  
  def recent
    render :inline => '<%= recent_messages(:break => true) %>'
  end
  
  def login
    login_to_chat
    render :nothing => true
  end

  def logout
    logout_of_chat
    render :nothing => true
  end
end