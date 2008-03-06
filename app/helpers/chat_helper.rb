module ChatHelper
  def previous_messages
    messages = []
    messages << { :from => 'Ryan H.',  :message => "what's happening with slate?"}
    messages << { :from => 'Chris S.', :message => "we'll be open-sourcing it soon..."}
    messages << { :from => 'Sam W.',   :message => "i think we should change the code to this:" }
    messages << { :from => 'Sam W.',   :message => "@message = Message.new\n@message.from = 'Guest'\n@message.message = data"}
    messages << { :from => 'Steve J.', :message => 'why?  it works just fine the way it is'}
    messages << { :from => 'Chris S.', :message => 'File: <a href="#">slate_wireframes.pdf</a>' }
    
    out = []
    for m in messages
      out << render(:partial => 'message', :object => m)
      params[:previous_speaker] = m.from
    end  
    out
  end
  
  def message_html(message)
    message =~ /\n/ ? '<pre>' + message.chomp + '</pre>' : message
  end
  
  def new_speaker?(message)
    params[:previous_speaker] != message.from
  end
end
