class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :user_id, index: true
      t.integer :video_id, index: true
      t.boolean :like, default: true

      t.timestamps
    end
  end
end
