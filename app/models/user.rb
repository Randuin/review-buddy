class User < ApplicationRecord
  has_many :user_pull_requests
  has_many :pull_requests, through: :user_pull_requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_github(access_token, user_data)
    first_or_create!(github_uid: user_data["id"]) do |user|
      user.email = user_data["email"] 
      user.password = Devise.friendly_token.first(8)
      user.github_access_token = access_token
    end
  end

  def update_auth_token
    assign_attributes(auth_token: "#{self.id}:#{Devise.friendly_token}")
  end

  def reviews
    pull_requests.reject { |pr| pr.reviewed }
  end

  def update_reviews_from_upstream_notifications 
    notifications = client.notifications
    reviews = ReviewNotificationExtractor.new(notifications).extract_reviews
    self.pull_requests += reviews
    save!
  end

  private

  def client
    @client ||= Github.new(github_access_token)
  end
end
