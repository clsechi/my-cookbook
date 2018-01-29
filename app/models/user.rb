class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorite_recipes
  has_many :favorites, through: :favorite_recipes, source: :recipe

  def favorited?(recipe)
    favorites.include? recipe
  end

  def editable_by?(user)
    id == user.id
  end

  def recipes_quant
    Recipe.where('user_id = ?', "#{id}").size
  end

  def recipes
    Recipe.where('user_id = ?', "#{id}")
  end
end
