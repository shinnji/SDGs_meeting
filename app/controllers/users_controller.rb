class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(3)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user =User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end 
  
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end 
  
    # def withdrawal
    # @user = User.find(params[:id])
    # # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    # @user.update(is_deleted: true)
    # reset_session
    # flash[:notice] = "退会処理を実行いたしました"
    # redirect_to root_path
    # end

  
  private
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end 
end
