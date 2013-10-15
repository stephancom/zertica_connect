class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_filter :load_project, except: :confirm_payment
  load_and_authorize_resource :order, through: :project, shallow: true, except: :confirm_payment
  before_filter :load_project_from_order, except: :confirm_payment

  def create
    @order = @project.orders.new(params[:order])
    flash[:notice] = 'Order was successfully created.' if @order.save
    respond_with @project, @order
  end

  def update
    flash[:notice] = 'Order was successfully updated.' if @order.update(params[:order])
    respond_with @project, @order
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  def estimate
    if @order.update(params[:order]) and @order.estimate!
      flash[:notice] = "Estimate of #{number_to_currency @order.price} submitted to client #{@order.user_name}"
    else
      flash[:error] = 'Estimate failed'
    end
    respond_with @project, @order
  end

  def pay
    if @order.update(params[:order]) and @order.pay!
      flash[:notice] = "Payment #{number_to_currency @order.price} tendered #{@order.confirmation}"
    else
      flash[:error] = 'Payment failed'
    end
    respond_with @project, @order
  end

  def confirm_payment
    @result = Braintree::TransparentRedirect.confirm(request.query_string)
    @order = Order.find(@result.transaction.custom_fields[:order_id]) if @result 
    if @result && @result.success?
      flash[:notice] = "Payment #{number_to_currency @result.transaction.amount} succeeded" if @order.update(confirmation: @result.transaction.id) and @order.pay!
    else
      flash[:error] = 'Payment failed'
    end
    redirect_to [@project, @order]
  end

  def complete
    flash[:notice] = "Order #{@order.title} completed!" if @order.complete!
    respond_with @project, @order
  end

  def ship
    @order.shippable_files.build(project: @project)
    if @order.update(params[:order]) and @order.ship!
      flash[:notice] = "Order #{@order.title} shipped via #{@order.carrier} tracking #{@order.tracking_number}"
    else
      flash[:notice] = 'Shipment failed'
    end
    respond_with @project, @order
  end

private
  # this one gets done first, for when you've got a nested path
  def load_project
    @project ||= Project.find(params[:project_id]) if params.has_key? :project_id
  end
  # and this one gets done after, in case you're in a shallow path.
  # there's probably a better, less redundant way to do this
  def load_project_from_order
    @project ||= @order.project if @order
  end

  def order_params
    case action_name
    when 'create'
      if current_admin
        params[:order].permit(:order_type, :title, :description, :price, project_file_ids: [], project_files_attributes: [:project_id, :url, :filename, :size, :mimetype])
      else
        params[:order].permit(:order_type, :title, :description, project_file_ids: [], project_files_attributes: [:project_id, :url, :filename, :size, :mimetype])
      end
    when 'estimate'
      params[:order].permit(:price)
    when 'pay'
      params[:order].permit(:confirmation)
    when 'confirm_payment'
      params.require(:bt_message) # special case - braintree response
    when 'complete'
      params[:order].permit()
    when 'ship'
      params[:order].permit(:carrier, :tracking_number, shippable_file_ids: [], shippable_files_attributes: [:project_id, :url, :filename, :size, :mimetype])
    else
      if current_admin
        params[:order].permit(:title, :description, :price, project_file_ids: [], project_files_attributes: [:project_id, :url, :filename, :size, :mimetype], shippable_files_attributes: [:project_id, :url, :filename, :size, :mimetype])
      else
        params[:order].permit(:title, :description, project_file_ids: [], project_files_attributes: [:project_id, :url, :filename, :size, :mimetype])
      end
    end
    # TODO allow carrier/tracking number/shipping files if admin and state completed
  end
end
