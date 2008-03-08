class GabberController < ApplicationController
  def idle
    current_user.away! 'idle'
    render :juggernaut do |page|
      page["g-#{current_user.id}"].className = 'idle'  
    end
    render :nothing => true
  end
  
  def offline
    current_user.offline!
    render :juggernaut do |page|
      # page["g-#{current_user.id}"].visual_effect :fade
      page["g-#{current_user.id}"].className = 'offline'
    end
    render :nothing => true
  end
  
  # Called when a user comes back online, or logs in
  def online
    current_user.online!
    render :juggernaut do |page|
      page["g-#{current_user.id}"].className = 'online'
    end
    render :nothing => true    
  end
end
