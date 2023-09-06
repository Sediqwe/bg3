class Game < ApplicationRecord
    has_one_attached :gameimage
    has_many :uploads, dependent: :destroy
    has_many :lines, dependent: :destroy
end
