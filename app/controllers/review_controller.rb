class ReviewController < ApplicationController
  def new
    @review = current_user.reviews.build  # form_with 用
  end
  
  def review
    @review = current_user.reviews.build  # form_with 用

    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      render 'books/index'
    else
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render :new
    end
  end
end
