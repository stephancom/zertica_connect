class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_filter :load_project
  # load_resource :project
  # load_and_authorize_resource :user
  load_and_authorize_resource :order, through: :project, shallow: true

  # GET /orders
  # GET /orders.xml
  def index
    # @orders = Order.all
    respond_with(@orders)
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    # @order = Order.find(params[:id])
    respond_with(@order)
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    # @order = Order.new
    respond_with(@order)
  end

  # GET /orders/1/edit
  def edit
    # @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    # @order = Order.new(params[:order])
    # throw @project.orders.new(params[:order])
    @order = @project.orders.new(params[:order])
    flash[:notice] = 'Order was successfully created.' if @order.save
    respond_with(@project, @order)
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    # @order = Order.find(params[:id])
    flash[:notice] = 'Order was successfully updated.' if @order.update(params[:order])
    respond_with(@order)
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    # @order = Order.find(params[:id])
    @order.destroy
    respond_with(@order)
  end

  def estimate
    if @order.update(params[:order]) and @order.estimate!
      flash[:notice] = "Estimate of #{number_to_currency @order.price} submitted to client #{@order.user_name}"
    else
      flash[:notice] = 'Estimate failed'
    end
    respond_with @order
  end

  def pay
    if @order.update(params[:order]) and @order.pay!
      flash[:notice] = "Payment #{number_to_currency @order.price} tendered #{@order.confirmation}"
    else
      flash[:notice] = 'Payment failed'
    end
    respond_with @order
  end

  def complete
    flash[:notice] = "Order #{@order.title} completed!" if @order.complete!
    respond_with @order
  end

  def ship
    if @order.update(params[:order]) and @order.ship!
      flash[:notice] = "Order #{@order.title} shipped via #{@order.carrier} tracking #{@order.tracking_number}"
    else
      flash[:notice] = 'Shipment failed'
    end
    respond_with @order
  end

private
  def load_project
    @project ||= Project.find(params[:project_id]) if params.has_key? :project_id
  end

  def order_params
    case action_name
    when 'create'
      params[:order].permit(:order_type, :title, :description, project_file_ids: [])
    when 'estimate'
      params[:order].permit(:price)
    when 'pay'
      params[:order].permit(:confirmation)
    when 'complete'
      params[:order].permit()
    when 'ship'
      params[:order].permit(:carrier, :tracking_number)
    else      
      params[:order].permit(:title, :description, project_file_ids: [])
    end
    # TODO allow carrier/tracking number/shipping files if admin and state completed
  end
end