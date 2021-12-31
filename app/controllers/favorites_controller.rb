class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    book = Book.find(params[:book_id])
    current_user.favorite(book)
    flash[:success] = 'この本をお気に入りに追加しました。'
    render 'books/index'
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.unfavorite(micropost)
    flash[:danger] = 'この本のお気に入りを解除しました。'
    render 'books/index'
  end
end
