module ChatHelper
  def previous_messages
    # messages = []
    # messages << { :from => 'Ryan H.',  :message => "what's happening with slate?"}
    # messages << { :from => 'Chris S.', :message => "we'll be open-sourcing it soon..."}
    # messages << { :from => 'Sam W.',   :message => "i think we should change the code to this:" }
    # messages << { :from => 'Sam W.',   :message => "@message = Message.new\n@message.from = 'Guest'\n@message.message = data"}
    # messages << { :from => 'Steve J.', :message => 'why?  it works just fine the way it is'}
    # messages << { :from => 'Chris S.', :message => 'File: <a href="#">slate_wireframes.pdf</a>' }
    
    out = []
    for m in Message.recent(5)
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
    out
  end
  
  def message_body(message)
    (m=message.message) =~ /\n/ ? '<pre>' + m.chomp + '</pre>' : m
  end
  
  def new_speaker?(message)
    params[:previous_speaker].try(:to_i) != message.user_id
  end
  
  def system_message?(message)
    message.system?
  end
  
  def message_class(message)
    classes = []
    classes << 'new' if new_speaker?(message)
    classes << 'sys' if system_message?(message)
    classes.join(' ')
  end
end
