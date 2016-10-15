class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :trips
  has_many :packing_lists, through: :trips
  has_many :resource_lists, through: :trips
  has_many :itineraries, through: :trips

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(first_name: data["first_name"],
            last_name: data["last_name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
        )
    end
    user
end
end