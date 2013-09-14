class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all
    respond_with(@projects)
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    respond_with(@project)
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    respond_with(@project)
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    flash[:notice] = 'Project was successfully created.' if @project.save
    respond_with(@project)
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    flash[:notice] = 'Project was successfully updated.' if @project.update(params[:project])
    respond_with(@project)
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_with(@project)
  end

  private

  def project_params
    params[:project].permit(:title, :spec, :deadline, :user_id)
  end
end
