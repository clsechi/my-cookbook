class Cuisine < ApplicationRecord

	validates :name, presence: true

	has_many :recipes

	#validates :name, uniqueness: true
	
end
