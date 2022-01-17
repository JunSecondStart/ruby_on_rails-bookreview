class AddContentToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :content, :string
  end
end
