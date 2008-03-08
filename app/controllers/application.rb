# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :login_required

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '12d2e0a7215f0f256b4655c623494982'
  
protected
  def render_juggernaut_message(message=nil)
    message ||= @message
    render :juggernaut do |page|
      page.insert_html :bottom, 'chat', :partial => 'chat/message', 
        :object => message
      page[:previous_speaker].value = message.user_id  
      page << 'document.body.scrollTop = document.body.scrollHeight';
    end
  end
  
  def logout_of_chat
    current_user.offline!
    render_juggernaut_message current_user.system(
      'left the chat'
    )
  end
  
  def login_to_chat
    current_user.online!
    render_juggernaut_message current_user.system(
      'joined the chat'
    )
  end
  
  
end