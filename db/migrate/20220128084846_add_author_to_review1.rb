class AddAuthorToReview1 < ActiveRecord::Migration[6.1]
  def change
    add_column :review1s, :author, :string
  end
end
