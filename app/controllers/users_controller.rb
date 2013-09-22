class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :get_messages, only: :show
  before_filter :new_message, only: :show
  
  def update
    flash[:notice] = 'User was successfully updated.' if @user.update(params[:user])
    respond_with(@user)
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    unless @user == current_user
      @user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  private

  def user_params
    if current_user.is_admin?
      params[:user].permit(:name, :email, :password, :password_confirmation, :role_ids)
    else
      params[:user].permit(:name, :email, :password, :password_confirmation)
    end
  end

  def get_messages
    @messages = @user.messages
  end

  def new_message
    @message = @user.messages.new
  end
end