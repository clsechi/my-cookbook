class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user

  has_many :favorite_recipes
  has_many :favorite_by, through: :favorite_recipes, source: :user

  validates :title, :difficulty, :cook_time, :ingredients, :method, presence: true

  # paperclip validations
  has_attached_file :photo, styles: { medium: '200x200>', thumb: '100x100>' }, default_url: '/images/missing.jpg'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  # validates_attachment_file_name :photo, matches: [/png\z/, /jpe?g\z/]

  def editable_by?(user)
    self.user == user
  end
end
