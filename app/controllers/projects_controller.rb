class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

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

  def project_params
    params[:project].permit(:title, :spec, :deadline)
  end
end
