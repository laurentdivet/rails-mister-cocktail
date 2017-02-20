class Cocktail < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :doses
  has_many :ingredients, through: :doses, dependent: :destroy
  has_attachment :photo
  paginates_per 21
  # include PgSearch
  # pg_search_scope :search_cocktail, against:  [name: 'A', instructions: 'B'], using: [:tsearch, :trigram, :dmetaphone]
end
