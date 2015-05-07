class UsersController < ApplicationController
  def index
    flash[:req_ip] = "IP Address = %s, UserAgent = %s" % [request.remote_ip, request.user_agent] # TODO : Multilingual/I18n
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:user][:username]
    @user.avatar = params[:user][:list][0]
    if @user.save
      flash[:notice] = "创建成功 ID=" + @user.id.to_s # TODO : Multilingual/I18n
      redirect_to @user
    else
      flash.now[:error] = "创建失败" # TODO : Multilingual/I18n
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :username)
  end
end
