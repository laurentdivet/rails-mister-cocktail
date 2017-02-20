class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :doses
  has_many :cocktails, through: :doses


  def self.names
    array = []
    self.all.each { |e| array << e.name }
    array
  end

  def self.names_with_index
    array = []
    self.all.each { |e| array << [e.name, e.id] }
    array
  end

end
