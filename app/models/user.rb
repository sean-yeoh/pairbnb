class User < ActiveRecord::Base
  include Clearance::User
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 8, too_short: "must be at least %{count} characters" }, on: :create

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.password = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).sample(rand(8..10)).join
      u.name = auth_hash["extra"]["raw_info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.remote_avatar_url = auth_hash["info"]["image"].gsub('http://','https://')
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

  enum role: [:tenant, :landlord, :superadmin]
end
