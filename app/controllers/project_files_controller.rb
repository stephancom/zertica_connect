class ProjectFilesController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  def index
    respond_with(@project_files)
  end

  def show
    respond_with(@project_file)
  end

  def new
    respond_with(@project_file)
  end

  def create
    @project_file.save
    respond_with(@project)
  end

  def update
    @project_file.update(params[:project_file])
    respond_with(@project, @project_file)
  end

  def destroy
    @project_file.destroy
    respond_with(@project)
  end

  private

  def project_file_params
    params[:project_file].permit(:url, :filename, :size, :mimetype)
  end
end
