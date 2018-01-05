class Recipe < ApplicationRecord

	 belongs_to :cuisine
	 belongs_to :recipe_type

	 validates :title, :difficulty, :cook_time, :ingredients, :method, presence: true

end
