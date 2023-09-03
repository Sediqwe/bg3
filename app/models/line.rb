class Line < ApplicationRecord
  belongs_to :game
  belongs_to :user
  paginates_per 10
  def self.ransackable_attributes(auth_object = nil)
    ["content", "contentuid"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["content", "contentuid"]
  end
  
end
