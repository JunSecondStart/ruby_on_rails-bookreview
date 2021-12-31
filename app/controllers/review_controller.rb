class ReviewController < ApplicationController
  def new
    @review = current_user.reviews.build  # form_with 用
  end
  
  def create
    @reviews = Review.new(review_params)
    
    if @reviews.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @review
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
    
    @books = Favorite.find(params[current_user.book_id])
    current_users.review(@books)
  end
  
    private

  def review_params
    params.require(:review).permit(:content)
  end
end
