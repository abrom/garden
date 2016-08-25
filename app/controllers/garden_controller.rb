class GardenController < ApplicationController
  def index
    render template: 'garden/app' if user_signed_in?
  end
end
