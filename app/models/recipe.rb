class Recipe < ApplicationRecord

	 belongs_to :cuisine
	 belongs_to :recipe_type
	 belongs_to :user

	 has_many :favorite_recipes
	 has_many :favorite_by, through: :favorite_recipes, source: :user

	 validates :title, :difficulty, :cook_time, :ingredients, :method, presence: true

end
