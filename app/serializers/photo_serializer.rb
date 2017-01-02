class PhotoSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :plant_id, :url, :thumb_url, :date_taken

  private

  def url
    object.photo_url
  end

  def thumb_url
    object.photo.thumb.url
  end

  def plant_id
    object.imageable_id
  end

  def date_taken
    object.created_at
  end
end
