class ActiveChatsController < ApplicationController
  before_filter :authenticate_admin!
  load_and_authorize_resource

  def create
    @active_chat = current_admin.active_chats.new(params[:active_chat])    
    flash[:notice] = 'ActiveChat was successfully created.' if @active_chat.save
    # respond_with(@active_chat)
    redirect_to root_path
  end

  def destroy
    @active_chat.destroy
    redirect_to root_path
  end

  private

  def active_chat_params
    params[:active_chat].permit(:user_id)
  end
end
