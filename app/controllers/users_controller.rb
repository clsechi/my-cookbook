class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user.editable_by? current_user
      render :edit
    else
      flash[:alert] = 'Usuário não possui as permissões necessarias'
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update user_params
      redirect_to @user
    else
      render :edit
    end
  end

  def recipes
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :city, :email, :facebook, :twitter)
  end
end
