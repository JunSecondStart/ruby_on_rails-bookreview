class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :microposts
    has_many :favorites, dependent: :destroy
    has_many :lovings, through: :favorites, source: :book
    has_many :review1s, dependent: :destroy
    has_many :books, through: :review1s, source: :book
    has_many :books
    
  def favorite(book)
      self.favorites.find_or_create_by(book_id: book.id)
      self.favorites.find_or_create_by(title: book.title)
      self.favorites.find_or_create_by(author: book.author)
      self.favorites.find_or_create_by(url: book.url)
      self.favorites.find_or_create_by(image_url: book.image_url)
  end

  def unfavorite(book)
    favorite = self.favorites.find_by(book_id: book.id)
    favorite.destroy if favorite
  end

  def loving?(book)
    self.lovings.include?(book)
  end
end
