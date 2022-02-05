class AddImageUrlToReview1 < ActiveRecord::Migration[6.1]
  def change
    add_column :review1s, :image_url, :string
  end
end
