class GenusSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :description, :hybrid
end
