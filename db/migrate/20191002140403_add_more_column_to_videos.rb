class AddMoreColumnToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :like, :integer
    add_column :videos, :dislike, :integer
    add_column :videos, :title, :string
    add_column :videos, :desc, :string
  end
end
