class Api::V1::SpeciesController < Api::V1::ApiController
  def index
    species =
      if query_term.present?
        Species.where('name like ?', "#{query_term}%")
      else
        Species.none
      end

    filtered = species.
      includes(:genus).
      joins('LEFT JOIN plants on plants.species_id = species.id').
      group('species.id').
      select('species.*, count(plants.id) as plant_count').
      limit(limit)

    render json: filtered, adapter: :json, meta: { total: Species.count, filtered: species.count }
  end

  def show
    species = Species.find(params[:id])
    render json: [species], adapter: :json
  end

  private

  def query_term
    @query_term ||= params[:query].to_s.downcase.gsub(/[^a-z ]/, '')
  end

  def limit
    @limit ||= params[:limit] || 20
  end
end
