# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_time
    Time.now.eztime(chat_time_format)
  end
  
  def chat_time_format
    ':hour12::minute :lmeridian'
  end
end
