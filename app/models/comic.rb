class Comic < ActiveRecord::Base
	has_many :comments
	belongs_to :arc
	has_many :tags, through: :comic_tags
	validates :position, uniqueness: true

  has_attached_file :image, default_url: "/assets/comics/comic1.jpg", storage: :s3, path: "#{COMIC_PATH}:id.:extension", s3_credentials: { bucket: "mayhemchampion", access_key_id: ENV["AWSKEY"], secret_access_key: ENV["AWSECRET"] }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	def format_time
		created_at.strftime('%b-%d-%Y')
	end

	def nextcom
		Comic.where(enabled: true).where('position > ?', position).try(:first)
	end

	def lastcom
		com = Comic.where(enabled: true).where('position < ?', position).try(:last)

		if com && com.arc == arc
			com
		elsif com.try(:arc)
			com.arc.comics.first
		else
			com
		end
	end
end