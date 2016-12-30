class Genus < ActiveRecord::Base
  belongs_to :family
  has_many :species
  has_many :plants, through: :species
end
