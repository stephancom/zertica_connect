class AssetsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  def index
    respond_with(@assets)
  end

  def show
    respond_with(@asset)
  end

  def new
    respond_with(@asset)
  end

  def create
    flash[:notice] = 'Asset was successfully created.' if @asset.save
    respond_with(@project)
  end

  def update
    flash[:notice] = 'Asset was successfully updated.' if @asset.update(params[:asset])
    respond_with(@project, @asset)
  end

  def destroy
    @asset.destroy
    respond_with @project
  end

  private

  def asset_params
    params[:asset].permit(:title, :notes, :visible)
  end
end
