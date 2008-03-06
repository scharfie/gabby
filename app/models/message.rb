class Message < ActiveRecord::Base
  belongs_to :user

  # Class methods
  def self.recent(limit=15)
    find(:all, :order => 'created_on DESC').reverse
  end
  
  def from
    user.try(:short_name) || '(unknown)'
  end
end