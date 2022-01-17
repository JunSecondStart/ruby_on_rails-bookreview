class Review1sController < ApplicationController
  before_action :require_user_logged_in

  def index
    @review1 = current_user.review1s.build(review1_params)
    if @review1.save
      flash[:success] = 'レビューを投稿しました。'
      render 'books/create'
    else
      @pagy, @review1 = pagy(current_user.review1s.order(id: :desc))
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'books/create'
    end
  end

  def new
    @title = params[:title]
    @author = params[:author]
    @image_url = params[:image_url]
  end

  def edit
    @review1 = Favorite.find(params[:id])
  end

  def update
  end

  def create
    @review1 = current_user.review1s.build(review1_params)
    if @review1.save
      flash[:success] = 'レビューを投稿しました。'
      render 'review1/new'
    else
      @pagy, @review1 = pagy(current_user.review1s.order(id: :desc))
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'review1/new'
    end
  end

  def destroy
  end

  private

  def review1_params
    params.require(:review1).permit(:content)
  end
end