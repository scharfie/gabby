module ChatHelper
  def recent_messages(options={})
    out = []
    for m in Message.recent(15)
      out << render(:partial => 'message', :object => m)
      params[:previous_speaker] = m.user_id
    end  
    
    # system message test
    # m = Message.system('mguymon left the chat.')
    # out << render(:partial => 'message', :object => m)
    # 
    # m = Message.system('swein joined the chat.')
    # out << render(:partial => 'message', :object => m)

    params[:previous_speaker] = nil
    
    if options[:break]
      m = current_user.system('joined the chat')
      out << render(:partial => 'message', :object => m)
      out << '<script type="text/javascript">this.juggernaut.onMessage();</script>'
    end

    out
  end
  
  def message_body(message)
    m = message.message
    if message.attachment?
      'uploaded ' + attachment_link(message.attachment)
    else  
      m =~ /\n/ ? '<pre>' + m.chomp + '</pre>' : m
    end  
  end
  
  def attachment_link(attachment)
    link_to(attachment.filename, attachment.public_filename)
  end
  
  def new_speaker?(message)
    params[:previous_speaker].try(:to_i) != message.user_id
  end
  
  def system_message?(message)
    message.system?
  end
  
  def message_class(message)
    classes = []
    classes << "u-#{message.user_id} m-#{message.id}"
    classes << 'new' if new_speaker?(message)
    classes << 'sys' if system_message?(message)
    classes << 'notice' if message.notice?
    classes.join(' ')
  end
end
