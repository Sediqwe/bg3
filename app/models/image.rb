class Image < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :upload
  has_one_attached :image, dependent: :destroy
end
