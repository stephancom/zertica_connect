class MessagesController < ApplicationController
  load_and_authorize_resource # through: :user, shallow: true

  before_filter :get_user
  before_filter :new_message, only: :index

  def index
    # @messages = user.messages
    respond_with(@messages)
  end

  # def show
  #   @message = Message.find(params[:id])
  #   respond_with(@message)
  # end

  # def new
  #   @message = Message.new
  #   respond_with(@message)
  # end

  def create
    # @message = Message.new(params[:message])
    @message.user = @user || current_user
    @message.admin = current_admin
    flash[:notice] = 'Message was successfully created.' if @message.save

    if @user
      respond_with @user
    else
      redirect_to messages_path
    end
    # respond_with(user || @messages)
  end

  # def destroy
  #   @message = Message.find(params[:id])
  #   @message.destroy
  #   respond_with(@message)
  # end

  def bookmark
    @message.toggle!(:bookmark)
    if current_admin
      respond_with @message.user
    else
      redirect_to messages_path
    end
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
