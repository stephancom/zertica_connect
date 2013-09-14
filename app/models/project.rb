class Project < ActiveRecord::Base
	include Stateflow

	belongs_to :user

	validates :user, presence: true

	#     _        _                       _    _          
	#  __| |_ __ _| |_ ___   _ __  __ _ __| |_ (_)_ _  ___ 
	# (_-<  _/ _` |  _/ -_) | '  \/ _` / _| ' \| | ' \/ -_)
	# /__/\__\__,_|\__\___| |_|_|_\__,_\__|_||_|_|_||_\___|
	stateflow do
		initial :preparing

		state :preparing, :submitted, :discovery, :estimate_submitted, :in_progress, :completed, :archived

		#     _        _          
		#  __| |_ __ _| |_ ___ ___
		# (_-<  _/ _` |  _/ -_|_-<
		# /__/\__\__,_|\__\___/__/                        

		state :submitted do
			enter :start_project
		end

		state :estimate_submitted do
			enter :send_estimate
		end

		state :completed do
			enter :thank_client
		end

		#                  _      
		#  _____ _____ _ _| |_ ___
		# / -_) V / -_) ' \  _(_-<
		# \___|\_/\___|_||_\__/__/

		event :submit do
			transitions from: :preparing, to: :submitted
		end

		event :edit_submission do
			transitions from: :submitted, to: :preparing
		end

		event :receive do
			transitions from: :submitted, to: :discovery
		end

		event :submit_estimate do
			transitions from: :discovery, to: :estimate_submitted
		end

		event :accept do
			transitions from: :estimate_submitted, to: :in_progress
		end

		event :decline do
			transitions from: :estimate_submitted, to: :discovery
		end

		event :complete do
			transitions from: :in_progress, to: :completed
		end

		event :archive do
			transitions from: [:discovery, :in_progress, :completed], to: :archived
		end

		event :unarchive do
			transitions from: :archived, to: [:discovery, :in_progress], decide: :estimated?
		end
	end

	# if there has been an estimate, we should unarchive to the discovery state, otherwise, to the in-progress state
	def estimated?
		# TODO
		# estimates.any? ? :discovery : :in_progress
		:in_progress # for now...
	end

	def send_estimate
		# send out the estimate
	end

	def start_project
		# let team members know there's a new job
		# thank client for their submission
	end

	def thank_client
		# send a thank you note to the client for a completed job
	end

	def spec_editable?
		[:preparing, :discovery, :in_progess].include? state
	end
end
