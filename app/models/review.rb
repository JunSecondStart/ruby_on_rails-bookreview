class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :star, numericality: { in: 1..5 }
  validates :heart, numericality: { in: 1..5 }
  validates :intelligence, numericality: { in: 1..5 }
  
   def review(current_user)
    if self == current_user
      self.reviews.find_or_create_by(user_id: current_user.id)
    end
  end
end
