class ChatController < ApplicationController
  def index
  end
	
  def new
    @message = current_user.messages.create!(:message => params[:message])
    render_juggernaut_message @message
    
    # render :juggernaut do |page|
    #       page.insert_html :bottom, 'chat', :partial => 'message'
    #       page[:previous_speaker].value = current_user.id
    #     end
    
    render :nothing => true
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