class MessagesController < ApplicationController
  load_and_authorize_resource # through: :user

  before_filter :new_message, only: :index

  def index
    @messages = user.messages
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
    @message.user = user
    @message.sender = current_user
    flash[:notice] = 'Message was successfully created.' if @message.save

    if current_user.has_role? :admin
      respond_with @message.user
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
    @message.toggle(:bookmark)
    @message.save!
    logger.debug "Toggle #{@message.inspect}"
    if current_user.has_role? :admin
      respond_with @message.user
    else
      redirect_to messages_path
    end
  end

  private

  def user
    @user ||= User.find(params[:user_id]) if params.has_key? :user_id
    @user ||= current_user
  end

  def new_message
    @message = user.messages.new
  end

  def message_params
    params[:message].permit(:body, :bookmark)
  end
end
