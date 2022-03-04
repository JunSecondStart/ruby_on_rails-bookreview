class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def index
    @pagy, @likes = pagy( Favorite.where(user_id: current_user.id).order(id: :DESC), items: 10)
    @current_user_likes = Favorite.where(user_id: current_user.id)
  end

  def create
    book = Book.find(params[:book_id])
    
      @book_data = 
      current_user.favorites.create(
        book_id: book.id,
        title: book.title,
        author: book.author,
        image_url: book.image_url,
        author: book.author
      )
    
      if @book_data.save 
      flash[:success] = 'この本をお気に入りに追加しました。よければレビューを投稿してください！！'
      @lovings = Favorite.all
       @pagy, @likes = pagy( Favorite.where(user_id: current_user.id).order(id: :DESC), items: 10)
      @current_user_likes = Favorite.where(user_id: current_user.id)
      @user = User.find(current_user.id)
      render 'users/likes'
    end
  end

  
  def destroy
    book = Book.find(params[:book_id])
    current_user.unfavorite(book)
    flash[:danger] = 'この本のお気に入りを解除しました。'
    @user = User.find(current_user.id)
    @likes = Favorite.where(user_id: @user.id)
    @pagy, @likes = pagy(@likes.order(id: :DESC), items: 10)
    counts(@user)
    $likes = @likes
    render 'users/likes'
  end
end
