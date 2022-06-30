class RelationshipsController < ApplicationController

  # フォローするとき
  def create
    # current_user.follow(params[:user_id])
    # redirect_to request.referer
    user = User.find(params[:user_id])
    current_user.follow(user)
		redirect_to request.referer
  end

  # フォロー外すとき
  def destroy
    # current_user.unfollow(params[:user_id])
    # redirect_to request.referer
    user = User.find(params[:user_id])
    current_user.unfollow(user)
		redirect_to request.referer
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end


# userモデルのfollow(user)、unfollow(user)のuser_id→user.idに変更
