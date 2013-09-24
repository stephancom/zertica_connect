class ApplicationController < ActionController::Base
	def current_ability
		@current_ability ||= Ability.new(current_account)	
	end

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	respond_to :html, :json

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_path, :alert => exception.message
	end

	# https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
	before_filter do
	  resource = controller_name.singularize.to_sym
	  method = "#{resource}_params"
	  params[resource] &&= send(method) if respond_to?(method, true)
	end

	before_filter :set_message_viewer

private

	def current_account
		current_admin || current_user
	end

	def set_message_viewer
		@message_viewer = current_account
	end
end
