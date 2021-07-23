class Article < ApplicationRecord
  validates :caption, presence: true
  has_rich_text :caption
  belongs_to :nutritionist
  has_many :acomments, dependent: :destroy
end
