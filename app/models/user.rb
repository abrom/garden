class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email, :google_uid

  def self.authorize_email(email)
    create! email: email
  end

  def self.from_omniauth(auth)
    user = find_by google_uid: auth.uid
    if user.nil?
      user = find_by email: auth.info.email
      user.update(google_uid: auth.uid, name: auth.info.name) if user
    end
    user
  end
end
