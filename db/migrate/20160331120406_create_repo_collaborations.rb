class CreateRepoCollaborations < ActiveRecord::Migration[5.0]
  def change
    create_table :repo_collaborations do |t|
      t.references :user, foreign_key: true
      t.references :repo, foreign_key: true

      t.timestamps
    end
  end
end
