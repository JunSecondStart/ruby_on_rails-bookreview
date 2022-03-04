class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 5)
  end

  def show
    @user = User.find(params[:id])
    counts(@user)
    $current_user_review1s=Review1.where(user_id: @user.id)
    @pagy, $current_user_review1s = pagy($current_user_review1s.order(id: :desc), items: 15)
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザーを新規登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = '新規登録を失敗しました。'
      render :new
    end
  end

  def likes
    @user = User.find(params[:id])
    @likes = Favorite.where(user_id: @user.id)
    @pagy, @likes = pagy(@likes.order(id: :DESC), items: 10)
    counts(@user)
    $likes = @likes
  end
  
  def review1s
    @user = User.find(params[:id])
    $personal_user_review1s=Review1.where(user_id: @user_id)
    $current_user_review1s=Review1.where(user_id: @user.id)
    @pagy, $current_user_review1s = pagy($current_user_review1s.order(id: :desc), items: 15)
    counts(@user)
    $user = @user
  end
  
  def followings
     @user = User.find(params[:id])
     @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
   private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end   
end
