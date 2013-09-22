class HomeController < ApplicationController
	def index
		redirect_to current_user.has_role?(:admin) ? dashboard_path : projects_path if current_user
	end

	def dashboard
		redirect_to projects_path unless current_user.has_role? :admin # hacky, fix this
		@clients = User.clients
		@projects = Project.all
	end
end
