class RepoCollaboration < ApplicationRecord
  belongs_to :user
  belongs_to :repo
end
