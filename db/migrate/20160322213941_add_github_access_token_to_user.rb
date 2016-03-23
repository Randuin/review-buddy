class AddGithubAccessTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :github_access_token, :string
    add_column :users, :github_uid, :string
  end
end
