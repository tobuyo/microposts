class LikerelationshipsController < ApplicationController
    before_action :logged_in_user
    
  
    
  def create
    
    @micropost = Micropost.find(params[:id])###followed_idからユーザー情報をとりだす
    #Likerelationship.create({like_id: current_user.id, liked_id: @micropost.id})
    #current_user.like_likerelationships.find_or_create_by(liked_id: @micropost)
    Likerelationship.find_or_create_by({like_id: current_user.id, liked_id: @micropost.id })
    # @like = current_user.like_likerelationships.build(like_id: @micropost)
    
  end

  def destroy
    @micropost = current_user.like_likerelationships.find_by(liked_id: params[:id])
    
    
    @micropost.destroy
    @micropost = Micropost.find(params[:id])
    #binding.pry
  end
end
