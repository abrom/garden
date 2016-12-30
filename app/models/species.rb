class Species < ActiveRecord::Base
  has_one :family, through: :genus
  belongs_to :genus
  has_many :plants

  enum taxonomic_status: [:accepted, :synonym, :unplaced, :unassessed]
  enum confidence_level: [:high, :medium, :low]
end
