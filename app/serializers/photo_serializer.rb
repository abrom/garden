class PhotoSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :url, :thumb_url

  private

  def url
    object.photo_url
  end

  def thumb_url
    object.photo.thumb.url
  end
end
