class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  acts_as_paranoid

  belongs_to :imageable, polymorphic: true
end
