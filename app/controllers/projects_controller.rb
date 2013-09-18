class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :new_message, only: :show

  def create
    flash[:notice] = 'Project was successfully created.' if @project.save
    respond_with(@project)
  end

  def update
    flash[:notice] = 'Project was successfully updated.' if @project.update(params[:project])
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private

  def new_message
    @message = @project.messages.new
  end

  def project_params
    params[:project].permit(:title, :spec, :deadline)
  end
end
