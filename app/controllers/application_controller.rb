class ApplicationController < ActionController::Base
  include SessionsHelper 
  include Review1sHelper
  include Pagy::Backend
  

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    $count_followings = user.followings.count
    $count_followers = user.followers.count
    $count_lovings = user.lovings.count
    $count_user_review1s = user.review1s.count
  end
end
