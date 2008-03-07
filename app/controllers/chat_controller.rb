class ChatController < ApplicationController
  def index
  end
	
  def new
    message = params[:message]
    render :nothing => true and return if message.blank?
    
    @message = nil
    
    if message =~ /^\/nick\s+(.*)/i
      prev = current_user.change_nickname!($1.chomp)
      @message = current_user.system 'is the artist formerly known as <span>' + prev + '</span>'
    elsif message =~ /^\/me\s+(.*)/
      @message = current_user.messages.create!(:message => '&bull; ' + $1.chomp)
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
  
  def broadcast
    render :nothing => true, :status => 200
  end

  def subscribe
    render :nothing => true, :status => 200
  end
end
