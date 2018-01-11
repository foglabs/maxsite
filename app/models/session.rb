class Session < ActiveRecord::Base

  def check
    Time.now - created_at < 14400
  end
end