class Announcement < ActiveRecord::Base

  validates_presence_of :body
  
  TYPES = ['public', 'private']

  scope :current, where(["(announce_on >= ? AND expire_by > ?) OR expire_by IS NULL",DateTime.now, DateTime.now]).order('announce_on DESC, expire_by DESC, id DESC')
  scope :for, lambda {|type| where(['announcement_type = ?',type])}

  def self.newest(type = nil)
    if TYPES.include?(type)
      Announcement.current.for(type).first
    else
      Announcement.current.first
    end
  end
  
  
end
