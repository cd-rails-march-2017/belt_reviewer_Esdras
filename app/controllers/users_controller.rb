class UsersController < ApplicationController

  def index
    if session[:id]
      redirect_to '/'
    else
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to '/'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/users'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(session[:id])
    @user.update(user_params)
    if @user.save
      redirect_to '/'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def login
    if @user = User.find_by(email: params[:user]['email'])
      if @user.password == params[:user]['password']
        session[:id] = @user.id
        redirect_to '/'
      else
        redirect_to '/users', notice: "Those passwords do not match!"
      end
    else
      redirect_to '/users', notice: "That username does not exist"
    end
  end

  def logout
    session.clear
    redirect_to '/users'
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
    end

end
