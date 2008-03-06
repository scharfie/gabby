class ChatController < ApplicationController
  def index
  end
	
  def new
    @message = current_user.messages.new(:message => params[:message])
    
    render :juggernaut do |page|
      page.insert_html :bottom, 'chat', :partial => 'message'
      page[:previous_speaker].value = current_user.id
    end
    
    render :nothing => true
  end
end