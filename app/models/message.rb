class Message < ActiveRecord::Base
  attr_accessor :system
  belongs_to :user

  ## Class methods

  # Returns recent messages
  def self.recent(limit=15)
    find(:all, :order => 'created_on DESC', :limit => limit).reverse
  end

  # Creates a system message (not to be saved!)
  def self.system(message)
    returning self.new(:system => true, :message => message) do |e|
      e.created_on = Time.now
      e.readonly!
    end
  end
  
  # def message
  #   system? ? "- #{self[:message]} -" : self[:message]
  # end
  
  # Returns who the message is from
  def from
    user.try(:short_name) || (system? ? '(SYSTEM)' : '(unknown)')
  end
  
  # Returns true if this is a system message
  def system?
    @system || false
  end
end