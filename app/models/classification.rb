class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest_boat = self.joins(:boats).order("boats.length DESC").limit(1).pluck("boats.id")
    self.joins(:boat_classifications).where("boat_classifications.boat_id = ?", longest_boat)
  end
end