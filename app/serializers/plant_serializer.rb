class PlantSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :date_added

  has_one :species
  has_many :photos

  private

  def date_added
    object.created_at
  end
end
