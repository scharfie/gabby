class Gabber < ActiveRecord::Base
  delegate :online?, :away?, :offline?, :to => :status
  delegate :nickname, :to => :user
  
  attr_accessor :previous_status
  belongs_to :user
  
  def self.gabbers
    find :all, :include => :user
  end
  
  def self.grab(user)
    gabber = find_or_initialize_by_user_id(User === user ? user.id : user)
  end
  
  def status
    @gs ||= GabberStatus.new(self[:status])
  end
  
  def previous_status
    @previous_status ||= GabberStatus.new(GabberStatus::OFFLINE)
  end
  
  def offline!
    self.previous_status = status
    update_attributes :status => GabberStatus::OFFLINE, :message => nil
    user.update_attribute :last_message_id, Message.last_message_id
  end
  
  def online!
    self.previous_status = status
    update_attributes :status => GabberStatus::ONLINE, :message => nil
  end
  
  def away!(msg=nil)
    self.previous_status = status
    update_attributes :status => GabberStatus::AWAY, :message => msg
  end
end

class GabberStatus
  OFFLINE = 0
  ONLINE  = 1
  AWAY    = 2
    
  attr_accessor :status
  
  def initialize(status)
    @status = status
  end
  
  def to_i
    @status
  end
  
  def to_s
    case @status
    when ONLINE
      'online'
    when OFFLINE
      'offline'  
    when AWAY
      'away'  
    end
  end
  
  def online?
    status == ONLINE
  end
  
  def offline?
    status == OFFLINE
  end
  
  def away?
    status == AWAY
  end  
  
  def ==(other)
    return to_i == other if Integer === other
    return to_s == other if String  === other
  end
end