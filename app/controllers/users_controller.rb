class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :get_messages, only: :show
  before_filter :new_message, only: :show

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
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

  def get_messages
    @messages = @user.messages
  end

  def new_message
    @message = @user.messages.new
  end
end