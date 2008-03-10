class Message < ActiveRecord::Base
  class << self
    attr_accessor :last_message_id  
  end
  
  attr_accessor :timestamp
  
  belongs_to :user
  belongs_to :asset

  # Ensure that we store who the message is from
  before_save do |e|
    e[:from] = e.from
  end
  
  # Track the last message id
  after_save do |e|
    Message.last_message_id = e.id
  end

  ## Class methods

  # Returns recent messages
  def self.recent(limit=15)
    find(:all, :order => 'created_on DESC', :limit => limit).reverse
  end
  
  # Returns all messages after given message ID
  def self.since(last_message_id)
    find :all, :order => 'created_on ASC',
      :conditions => ['id >= ?', last_message_id]
  end

  # Creates a system message
  def self.system(message)
    self.create! :system => true, :message => message
  end
  
  def self.timestamp
    returning self.new(:system => true, :timestamp => true) do |e|
      e.created_on = Time.now
      e.message = e.created_on.eztime(':nday, :nmonth :day:ordinal, :year')
      e.readonly!
    end
  end
  
  def attachment
    asset
  end
  
  def has_attachment?
    !asset.nil?
  end
  
  alias_method :attachment?, :has_attachment?
  
  # def message
  #   system? ? "- #{self[:message]} -" : self[:message]
  # end
  
  # Returns who the message is from
  def from
    super || user.try(:short_name) || (system? ? '' : '(unknown)')
  end
  
  # Returns true if this is a system message
  # def system?
  #   @system || false
  # end

  def notice?
    super || attachment?
  end
  
  def timestamp?
    @timestamp
  end
  
  # def created_on
  #   self[:created_on] || Time.now
  # end
end