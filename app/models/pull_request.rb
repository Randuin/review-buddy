class PullRequest < ApplicationRecord
  has_many :user_pull_requests
  has_many :users, through: :user_pull_requests
end
