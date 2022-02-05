class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @lovings = current_user.lovings
  end
  
  
  def create
    book = Book.find(params[:book_id])
    current_user.favorite(book)
    @title = Favorite.new(params[:title])
    current_user.favorite($title)
    @author = Favorite.new(params[:author])
    current_user.favorite($author)
    @url = Favorite.new(params[:url])
    current_user.favorite($url)
    @image_url = Favorite.new(params[:image_url])
    current_user.favorite($image_url)
    
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
