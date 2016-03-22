class CreatePullRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :pull_requests do |t|
      t.integer :user_id
      t.boolean :closed
      t.boolean :reviewed
      t.integer :github_id
      t.string :title
      t.string :url
      t.timestamps
    end
  end
end
