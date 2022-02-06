class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    book = Book.find(params[:book_id])
    current_user.favorite(book)
    
    
    
    flash[:success] = 'この本をお気に入りに追加しました。'
    render 'books/create'
  end
  
  def destroy
    book = Book.find(params[:book_id])
    current_user.unfavorite(book)
    flash[:danger] = 'この本のお気に入りを解除しました。'
    render 'books/create'
  end
end
