class HomeController < ApplicationController
	def dashboard
		redirect_to projects_path unless current_user.has_role? :admin # hacky, fix this
		@clients = User.clients
		@projects = Project.all
	end
end
