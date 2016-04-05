class AddIssueNumberOwnerAndRepoToPullRequest < ActiveRecord::Migration[5.0]
  def change
    remove_column :pull_requests, :github_id
    add_column :pull_requests, :merged, :boolean
    add_column :pull_requests, :repo, :string
    add_column :pull_requests, :owner, :string
    add_column :pull_requests, :number, :string
  end
end
