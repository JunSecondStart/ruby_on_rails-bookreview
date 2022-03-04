class ToppagesController < ApplicationController
   def index
    if logged_in?
      @user = User.find(current_user.id)
      $current_user_review1s=Review1.where(user_id: current_user.id)
      @pagy, $current_user_review1s = pagy($current_user_review1s.order(id: :ASC), items: 15)
    end
  end
end
