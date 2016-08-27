class Comic < ActiveRecord::Base
	has_many :comments
	has_many :tags, through: :comic_tags
	validates :position #, uniqueness: true

  has_attached_file :image, default_url: "/assets/comics/comic1.jpg", storage: :s3, path: "comics/:id.:extension", s3_credentials: { bucket: "mayhemchampion", access_key_id: ENV["AWSKEY"], secret_access_key: ENV["AWSECRET"] }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	def format_time
		created_at.strftime('%b-%d-%Y')
	end

	def nextcom
		Comic.where('position > ?', position).try(:first)
	end

	def lastcom
		Comic.where('position < ?', position).try(:last)
	end
end