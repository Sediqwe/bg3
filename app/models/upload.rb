class Upload < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one_attached :file, dependent: :destroy
  has_many :lines, dependent: :destroy_all
  
end
