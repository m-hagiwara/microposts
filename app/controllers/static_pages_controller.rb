class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).paginate(page: params[:page], :per_page => 10) # mod 20160312
    end
  end
end
