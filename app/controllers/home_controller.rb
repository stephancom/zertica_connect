class HomeController < ApplicationController
	def dashboard
		@clients = User.all
		@projects = Project.all
	end
end
