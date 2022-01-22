class Review1sController < ApplicationController
  before_action :require_user_logged_in

def add_user
    @group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    @group.users << user
    redirect_to group_path, notice: "ユーザーを追加しました。"
  end

  def new
    @title = params[:title]
    @author = params[:author]
    @image_url = params[:image_url]
    @user_id = current_user.id
  end

  def edit
    @review1 = Favorite.find(params[:id])
  end

  def update
  end

  def create
    @title = params[:title]
    @author = params[:author]
    @image_url = params[:image_url]
    
    book = Book.find_by(params[:title])
    @review1 = 
      current_user.review1s.create(
        content: review1_params[:content],
        book_id: book.id,
        title: book.title
        )
      
      
    if @review1.save 
      flash[:success] = 'レビューを投稿しました。'
      render 'review1s/index'
    else
      @pagy, @review1 = pagy(current_user.review1s.order(id: :desc))
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
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