class RecipeType < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :recipes, dependent: :destroy
end
