class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  
  def show 
   @user = User.find(params[:id]) ###@UserにURLのIDをいれてる
   @microposts = @user.microposts.order(created_at: :desc)
   ##descによってオーダーされた@userに紐付いたmicropostsを。
   
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
      redirect_to user_url(current_user)  , notice: 'メッセージを編集しました'
      else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
      end
     end
    end
    
  def followings
    @user = User.find(params[:id]) ###@UserにURLのIDをいれてる
    @users = @user.following_users
    @title = "#{@user.name}のフォロー"
    render 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id]) ###@UserにURLのIDをいれてる
    @users = @user.follower_users ###relationshipsを全部読み込んだ
    @title = "#{@user.name}のフォロワー"
    render 'show_follow'
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
