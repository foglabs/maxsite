class Arc < ActiveRecord::Base
  has_many :comics
  validates :title, uniqueness: true
end