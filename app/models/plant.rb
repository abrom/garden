class Plant < ActiveRecord::Base
  has_one :family, through: :genus
  has_one :genus, through: :species
  belongs_to :species
  has_many :photos, as: :imageable
end
