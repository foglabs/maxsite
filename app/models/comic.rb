class Comic < ActiveRecord::Base
	has_many :comments
	has_many :tags, through: :comic_tags
	validates :position, uniqueness: true

  has_attached_file :image, :default_url => "/assets/comics/comic1.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


	def nextcom
		first = Comic.where('position > ?', position).try(:first)
	end

	def lastcom
		last = Comic.where('position < ?', position).try(:last)
	end
end