class Api::V1::PlantsController < Api::V1::ApiController
  def show
    plant = Plant.find(params[:id])
    render json: [plant], adapter: :json
  end
end
