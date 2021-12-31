class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :microposts
    has_many :favorites
    has_many :lovings, through: :favorites, source: :book
    has_many :reviews, dependent: :destroy
    has_many :books, through: :reviews, source: :book
    
  def favorite(book)
      self.favorites.find_or_create_by(book_id: book.id)
  end

  def unfavorite(book)
    favorite = self.favorites.find_by(book_id: book.id)
    favorite.destroy if favorite
  end

  def loving?(book)
    self.lovings.include?(book)
  end
  
  def review(book)
      self.reviews.find_or_create_by(book_id: book.id)
  end
end
