class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def show 
   @user = User.find(params[:id])
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
    
    unless current_user==@user
      redirect_to root_path , notice: '現在のユーザーではありません'
    end
  end


  def update
     @user = User.find(params[:id])
    unless current_user==@user
      redirect_to root_path , notice: '現在のユーザーではありません'
      
     else
    
      if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
      else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
      end
     end
    end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:profile,:region)
  end
  
# ログイン済みか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  
end
