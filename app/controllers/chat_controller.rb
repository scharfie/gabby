class ChatController < ApplicationController
  def index
  end
	
  def new
    @message = current_user.messages.create!(:message => params[:message])
    
    render :juggernaut do |page|
      page.insert_html :bottom, 'chat', :partial => 'message'
      page[:previous_speaker].value = current_user.id
    end
    
    render :nothing => true
  end
  
  def login
    
    render :nothing => true
  end

  def logout
    render :juggernaut do |page|
      page.call :alert, "User logged out (#{current_user.login})"
    end
    
    render :nothing => true
  end
end