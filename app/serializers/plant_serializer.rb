class PlantSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id

  has_one :species
  has_many :photos
end
