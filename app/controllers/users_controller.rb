class UsersController < ApplicationController

  before_action :collect_user, only: [:edit, :update]

  def show # 追加
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
 
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Has been updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def followings
    @title = "Followings"
    @user  = User.find(params[:id])
#   @users = @user.followings
    @users = @user.followings.paginate(page: params[:page], :per_page => 20)
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
#   @users = @user.followers
    @users = @user.followers.paginate(page: params[:page], :per_page => 30)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :teln)
  end

  def collect_user
    user = User.find(params[:id])
    if !current_user?(user)
      redirect_to(root_url)
    end
  end
  
end