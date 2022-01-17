class AddTitleToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :title, :string
    add_column :favorites, :author, :string
    add_column :favorites, :url, :string
    add_column :favorites, :image_url, :string
  end
end
