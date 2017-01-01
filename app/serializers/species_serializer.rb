class SpeciesSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :common_name, :description, :authorship, :source, :source_id,
    :combined_source_id, :ipni_id, :publication, :collation, :date, :taxonomic_status,
    :confidence_level, :hybrid

  has_one :genus
end
