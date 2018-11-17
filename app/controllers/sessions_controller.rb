class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])

    if user
      login!(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end
  end


  def destroy
    log_out!
    redirect_to users_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

end
