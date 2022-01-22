class AddTitleToReview1 < ActiveRecord::Migration[6.1]
  def change
    add_column :review1s, :title, :string
  end
end
