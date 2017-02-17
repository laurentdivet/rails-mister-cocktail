class Cocktail < ApplicationRecord
  has_many :doses
  has_many :ingredients, through: :doses
  has_attachment :picture
end
