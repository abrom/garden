class Api::V1::PlantsController < Api::V1::ApiController
  def show
    plant = Plant.find(params[:id])
    render json: [plant], adapter: :json
  end

  def create
    species = Species.find(params[:plant][:species_id])
    plant = species.plants.create plant_params
    render json: SimplePlantSerializer.new(plant)
  end

  private

  def plant_params
    params.require(:plant).permit(:species_id)
  end
end
