class Arc < ActiveRecord::Base
  has_many :comics
  validates :title, uniqueness: true

  def nextarc
    Arc.order(arc_position: :asc).where(enabled: true).where('arc_position > ?', arc_position).try(:first).try(:comics).try(:order, position: :asc).try(:first)
  end

  def lastarc
    Arc.order(arc_position: :desc).where(enabled: true).where('arc_position < ?', arc_position).try(:first).try(:comics).try(:order, position: :asc).try(:first)
  end
end