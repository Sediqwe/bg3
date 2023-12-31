class Line < ApplicationRecord
  belongs_to :game
  belongs_to :user
  
  def self.ransackable_attributes(auth_object = nil)
    ["content", "contentuid","datatype", "oke"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["content", "contentuid", "datatype", "oke"]
  end
  validates :content, presence: true
  
end
