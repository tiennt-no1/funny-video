class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :youtube_url
      t.integer :created_by

      t.timestamps
    end
  end
end
