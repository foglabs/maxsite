class Comment < ActiveRecord::Base
  belongs_to :comic

  def format_time
    created_at.strftime('%b-%d-%Y')
  end
end