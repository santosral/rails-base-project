class Food < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :name, presence: true
  belongs_to :food_group
  belongs_to :user
  has_many :comments
  has_many :nutritional_informations
  mount_uploader :image, ImageUploader
end
