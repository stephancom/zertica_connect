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
    @user.destroy
    respond_with(@user)
  end

  private

  def user_params
    if current_user.has_role :admin
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