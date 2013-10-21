class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_filter :load_project, except: :confirm_payment
  load_and_authorize_resource :order, through: :project, shallow: true, except: :confirm_payment
  before_filter :load_project_from_order, except: :confirm_payment

  def create
    @order = @project.orders.new(params[:order])
    @order.save
    respond_with @project, @order
  end

  def update
    @order.update(params[:order])
    respond_with @project, @order
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  def estimate
    unless @order.update(params[:order]) and @order.estimate!
      flash[:error] = 'Estimate failed'
    end
    respond_with @project, @order
  end

  def pay
    unless @order.update(params[:order]) and @order.pay!
      flash[:error] = 'Payment failed'
    end
    respond_with @project, @order
  end

  def confirm_payment
    @result = Braintree::TransparentRedirect.confirm(request.query_string)
    @order = Order.find(@result.transaction.custom_fields[:order_id]) if @result 
    if @result && @result.success?
      @order.update(confirmation: @result.transaction.id) and @order.pay!
    else
      flash[:error] = 'Payment failed'
    end
    redirect_to [@project, @order]
  end

  def complete
    @order.complete!
    respond_with @project, @order
  end

  def ship
    @order.shippable_files.build(project: @project)
    unless @order.update(params[:order]) and @order.ship!
      flash[:error] = 'Shipment failed'
    end
    respond_with @project, @order
  end

  def archive
    @order.archive!
    respond_with @project    
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
    when 'archive'
      params[:order].permit()
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
