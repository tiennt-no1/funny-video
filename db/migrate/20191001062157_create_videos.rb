class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :youtube_url, default: ''
      t.integer :created_by

      t.timestamps
    end
  end
end
