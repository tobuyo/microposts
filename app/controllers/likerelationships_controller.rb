class LikerelationshipsController < ApplicationController
    before_action :logged_in_user
    
  def create
    @micropost = Micropost.find_by_id(params[:liked_id])###followed_idからユーザー情報をとりだす
    @like = current_user.like_likerelationships.build(micropost: @micropost)
    
    if @like.save
        redirect_to microposts_url, notice:"お気に入りしたよ"
    else
        redirect_to microposts_url, alert:"残念、お気に入りできませんね"
    end
  end

  def destroy
    @like = current_user.like_likerelationships.find_by!(micropost_id: params[:micropost_id])
    @like.destroy
    redirect_to micropost_url,notice:"解除した"
  end
end
