class User < ApplicationRecord
  has_many :user_pull_requests
  has_many :pull_requests, through: :user_pull_requests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_github(user_data)
    # TODO: Do this properly :)
    new(email: user_data[:email], password: '123')
  end

  def reviews
    pull_requests.reject { |pr| pr.reviewed }
  end

  def update_auth_token
    assign_attributes(auth_token: "#{self.id}:#{Devise.friendly_token}")
  end
end
