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
    @count_microposts = user.microposts.count
    @count_lovings = user.lovings.count
  end
end
