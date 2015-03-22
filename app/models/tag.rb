class Tag < ActiveRecord::Base
  validates :word, uniqueness: true
	has_many :comics, through: :comic_tags
  has_many :comic_tags
  accepts_nested_attributes_for :comic_tags
end