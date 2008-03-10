# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_time
    Time.now.eztime(chat_time_format)
  end
  
  def chat_time_format
    ':hour12::minute :lmeridian'
  end
  
  def glyph(name)
    image_tag "glyphs/#{name}.png", :class => 'glyph'
  end
  
  def add_message(message)
    page.insert_html :bottom, 'chat', :partial => 'chat/message', 
      :object => message
    page[:previous_speaker].value = message.user_id  
    page << 'document.body.scrollTop = document.body.scrollHeight';
  end
  
  def go_offline(user)
    page["g-#{user.id}"].className = 'offline'
    page.add_message user.system('left the chat')
  end
  
  def go_online(user)
    page["g-#{user.id}"].className = 'online'
    page.add_message user.system('joined the chat')
  end
  
  def go_away(user)
    page["g-#{user.id}"].className = 'idle'
    page.add_message user.system('went away')
  end
end
