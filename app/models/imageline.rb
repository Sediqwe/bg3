class Imageline < ApplicationRecord
  belongs_to :image
  belongs_to :line
  belongs_to :user
end
