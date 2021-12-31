class AddStarToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :star, :int
    add_column :reviews, :heart, :int
    add_column :reviews, :intelligence, :int
  end
end
