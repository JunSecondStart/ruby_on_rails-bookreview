class CreateReview1s < ActiveRecord::Migration[6.1]
  def change
    create_table :review1s do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
