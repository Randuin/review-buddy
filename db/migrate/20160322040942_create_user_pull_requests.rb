class CreateUserPullRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :user_pull_requests do |t|
      t.integer :user_id
      t.integer :pull_request_id
      t.timestamps
    end
  end
end
