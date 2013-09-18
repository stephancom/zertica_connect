class MessagesController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :message, through: [:project, :current_user]

  # def index
  #   @messages = Message.all
  #   respond_with(@messages)
  # end

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
    @message.user = current_user
    flash[:notice] = 'Message was successfully created.' if @message.save
    respond_with(@project)
  end

  # def destroy
  #   @message = Message.find(params[:id])
  #   @message.destroy
  #   respond_with(@message)
  # end

  private

  def message_params
    params[:message].permit(:body, :bookmark)
  end
end
