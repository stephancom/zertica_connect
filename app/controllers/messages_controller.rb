class MessagesController < ApplicationController
  load_and_authorize_resource # through: :user, shallow: true

  before_filter :get_user
  before_filter :new_message, only: :index

  def index
    respond_with(@messages)
  end

  def create
    @message.user = @user || current_user
    @message.admin = current_admin
    flash[:notice] = 'Message was successfully created.' if @message.save
  end

  def bookmark
    @message.toggle!(:bookmark)
  end

  private

  def get_user
    @user = User.find(params[:user_id]) if params.has_key? :user_id
  end

  def new_message
    @message ||= @user.messages.new if @user
    @message ||= current_user.messages.new if current_user
  end

  def message_params
    params[:message].permit(:body, :bookmark)
  end
end
