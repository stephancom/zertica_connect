class AssetsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  # GET /assets
  # GET /assets.xml
  def index
    # @assets = Asset.all
    respond_with(@assets)
  end

  # GET /assets/1
  # GET /assets/1.xml
  def show
    # @asset = Asset.find(params[:id])
    respond_with(@asset)
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    # @asset = Asset.new
    respond_with(@asset)
  end

  # GET /assets/1/edit
  # def edit
  #   @asset = Asset.find(params[:id])
  # end

  # POST /assets
  # POST /assets.xml
  def create
    # @asset = Asset.new(params[:asset])
    flash[:notice] = 'Asset was successfully created.' if @asset.save
    respond_with(@project, @asset)
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    # @asset = Asset.find(params[:id])
    flash[:notice] = 'Asset was successfully updated.' if @asset.update(params[:asset])
    respond_with(@project, @asset)
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    # @asset = Asset.find(params[:id])
    @asset.destroy
    respond_with(@project, @asset)
  end

  private

  def asset_params
    params[:asset].permit(:title, :notes, :visible)
  end
end
