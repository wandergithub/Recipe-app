class Food < ApplicationRecord
  belongs_to :user

  has_many :recipes, through: :recipe_foods

  validates :name, precence: true
end
