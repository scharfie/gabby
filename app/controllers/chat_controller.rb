class ChatController < ApplicationController
  def index
  end
	
  def new
    session[:user_id] = 175
    
    @message = Message.new
    @message.from = params[:from] #'Guest'
    @message.message = params[:message]
    
    render :juggernaut do |page|
      page.insert_html :bottom, 'chat', :partial => 'message'
      page[:previous_speaker].value = @message.from
    end
    
    render :nothing => true
  end
end