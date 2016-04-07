class User < ApplicationRecord
  has_many :user_pull_requests
  has_many :pull_requests, through: :user_pull_requests
  has_many :repo_collaborations
  has_many :repos, through: :repo_collaborations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_github(access_token, user_data)
    user = User.find_or_initialize_by(github_uid: user_data["id"]) do |user|
      user.email = user_data["email"] 
      user.password = Devise.friendly_token.first(8)
      user.github_access_token = access_token
    end

    user.save!
    user
  end

  def update_auth_token!
    self.auth_token = "#{self.id}:#{Devise.friendly_token}"
    save!
  end

  def reviews
    pull_requests.reject { |pr| pr.reviewed || pr.closed }
  end

  def reviewed
    pull_requests.select { |pr| pr.reviewed }
  end

  def client
    @client ||= Github.new(github_access_token)
  end
end
