class Api::V1::PhotosController < Api::V1::ApiController
  def create
    plant = Plant.find(photo_params[:plant_id])
    photo = plant.photos.create(photo: photo_params[:image])
    render json: [photo], adapter: :json
  end

  private

  def photo_params
    params.require(:photo).permit(:plant_id, :image)
  end
end
