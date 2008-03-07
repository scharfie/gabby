class AssetsController < ApplicationController
  def create
    @asset = Asset.new(params[:asset])
    
    if @asset.save
      @message = current_user.messages.create! :asset => @asset
      render_juggernaut_message
    else
      render :juggernaut do |page|
        page.call :alert, "Unable to save file :("
      end
    end
    
    render :nothing => true
  end
end
