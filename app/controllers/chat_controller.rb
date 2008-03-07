class ChatController < ApplicationController
  def index
  end
	
  def new
    @message = current_user.messages.create!(:message => params[:message])
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