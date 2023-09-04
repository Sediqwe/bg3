class Logola < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :upload
end
