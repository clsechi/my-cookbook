class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe

  def favorited? recipe
    self.favorites.include? recipe
  end
end
