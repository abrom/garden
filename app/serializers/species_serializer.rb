class SpeciesSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :common_name, :description, :authorship, :source, :source_id,
    :combined_source_id, :ipni_id, :publication, :collation, :date, :taxonomic_status,
    :confidence_level, :hybrid, :plant_count

  has_one :genus
  has_many :plants, serializer: SimplePlantSerializer

  def filter(keys)
    keys.delete :plant_count unless object.respond_to? :plant_count
    keys
  end
end
