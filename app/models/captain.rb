class Captain < ActiveRecord::Base
  has_many :boats

  def self.capitain_by_boat_classification(args)
    self.joins(:boats => :classifications).where(classifications: {name: args[:classification_name]})
  end

  def self.catamaran_operators
    #TODO add this to my notebook
    self.capitain_by_boat_classification(classification_name: "Catamaran")
  end

  def self.sailors
    self.capitain_by_boat_classification(classification_name: "Sailboat").uniq
  end

  def self.talented_seamen
    motorboats_captains = self.capitain_by_boat_classification(classification_name: "Motorboat")
    sailors.where(id: motorboats_captains.pluck(:id))
  end

  def self.non_sailors
    self.joins(:boats => :classifications).where("captains.id NOT IN (?)", sailors.pluck(:id)).uniq
  end
end
