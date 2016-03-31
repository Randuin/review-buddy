class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.integer :github_id
      t.string :url
      t.string :name
      t.string :webhook_url
      t.string :webhook_id
      t.timestamps
    end
  end
end
