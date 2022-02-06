class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 5)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
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

  def edit
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = Favorite.where(user_id: @user.id)
    @pagy, @lovings = pagy(@likes)
    counts(@user)
  end
  
  def review1s
    @user = User.find(params[:id])
    $curent_user_review1s=Review1.where(user_id: @user.id)
    @pagy, $curent_user_review1s = pagy($curent_user_review1s.order(id: :desc), items: 15)
  end
  
   private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end   
end
