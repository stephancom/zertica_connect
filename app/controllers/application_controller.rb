class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	respond_to :html

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_path, :alert => exception.message
	end

	# cargo cult
	# https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
	# TODO is this needed?
	before_filter do
	  resource = controller_name.singularize.to_sym
	  method = "#{resource}_params"
	  params[resource] &&= send(method) if respond_to?(method, true)
	end
end
