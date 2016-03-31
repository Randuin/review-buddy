class Repo < ApplicationRecord
  has_many :repo_collaborations
  has_many :users, through: :repo_collaborations
end
