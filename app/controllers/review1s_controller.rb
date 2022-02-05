class Review1sController < ApplicationController
  before_action :require_user_logged_in

  def index
    @pagy,@review1 = pagy(Review1.find_by(user_id: current_user.id).order(id: :desc), items: 15)
    $title = @review1.title
    $author = @review1.author
    $image_url = @review1.image_url
  end

  def new
  end

  def edit
    @review1 = Favorite.find(params[:id])
  end

  def update
  end

  def create
    @current_book = Book.where(title: $title).last
    
    @review1 = 
      current_user.review1s.create(
        content: review1_params[:content],
        book_id: @current_book.id,
        title: $title,
        name: current_user.name,
        image_url: $image_url,
        author: $author
        )
        
    if @review1.save 
      flash[:success] = 'レビューを投稿しました。'
      $review1s = Review1.where(title: $title) 
      $review1 = $review1s.last
      $curent_user_review1s=Review1.where(user_id: current_user.id)
      render 'review1s/index'
    else
      @pagy, @review1 = pagy(current_user.review1s.order(id: :desc))
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      $curent_user_review1s=Review1.where(user_id: current_user.id)
      render 'review1s/index'
    end
  end
  
  def destroy
  end

  private

  def review1_params
    params.permit(:content)
  end
end