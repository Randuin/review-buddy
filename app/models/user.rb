class User < ApplicationRecord
  has_many :pull_requests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def reviews
    pull_requests.reject { |pr| pr.reviewed }
  end

  def update_auth_token
    assign_attributes(auth_token: "#{self.id}:#{Devise.friendly_token}")
  end
end
