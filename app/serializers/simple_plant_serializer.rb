class SimplePlantSerializer < PlantSerializer
  root 'plants'

  def filter(keys)
    keys.delete :species
    keys
  end
end
