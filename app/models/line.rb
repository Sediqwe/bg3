class Line < ApplicationRecord
  belongs_to :game
  belongs_to :user
  paginates_per 10 
end
