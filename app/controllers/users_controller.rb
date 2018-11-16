class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render :show
    else
      flash[:errors] = ["User not found"]
      redirect_to users_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.create(user_params)

    if user.save
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end
  end


  def edit
    @user = User.find_by(id: params[:id])

    if @user
      render :edit
    else
      flash[:errors] = ["Le Uze est not fondue"]
      redirect_to users_url
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
