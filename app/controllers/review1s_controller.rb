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
    @review1 = Review1.find(params[:id])
  end

  def update
    @review1 = Review1.find(params[:id])
    if @review1.update(review1_create_params)
      flash[:success] = 'review は正常に更新されました'
      render 'review1s/edit'
    else
      flash.now[:danger] = 'review は更新されませんでした'
      render 'review1s/edit'
    end
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
      $current_book_review1s=Review1.where(title: $title)
      render 'review1s/create'
    else
      @pagy, @review1 = pagy(current_user.review1s.order(id: :desc))
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      $curent_user_review1s=Review1.where(user_id: current_user.id)
      render 'review1s/create'
    end
  end
  
  def destroy
    @review1 = Review1.find(params[:id])
    @review1.destroy
    flash[:success] = 'レビューを削除しました。'
    $current_book_review1s = Review1.where(title: params[:title])
    render 'review1s/book_review1s'
  end
  
  def book_review1s
    $current_book_review1s=Review1.where(title: params[:title])
  end
  
  def personal_review1s
    $user = User.find(params[:user_id])
    $personal_user_review1s = Review1.where(user_id: params[:user_id])
  end
  
  def my_review1s
    @user = User.find(current_user.id)
    $current_user_review1s=Review1.where(user_id: current_user.id)
    @pagy, $current_user_review1s = pagy($current_user_review1s.order(id: :ASC), items: 15)
    @all=Review1.all.count
  end

  private

  def review1_params
    params.permit(:content)
  end
  
  def review1_create_params
    params.require(:review1).permit(:content)
  end
end