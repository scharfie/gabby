class Gabber < ActiveRecord::Base
  belongs_to :user
  
  ONLINE = 0
  AWAY   = 1
  
  def self.grab(user)
    gabber = find_or_initialize_by_user_id(User === user ? user.id : user)
  end
  
  def self.update_status(user_id, status=ONLINE, message=nil)
    gabber = grab(user_id)
    gabber.online!    if status == ONLINE
    gabber.away!(msg) if status == AWAY
  end
  
  def online!
    update_attributes :status => ONLINE, :message => nil
  end
  
  def away!(msg=nil)
    update_attributes :status => AWAY, :message => msg
  end
end