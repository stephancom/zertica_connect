class Order < ActiveRecord::Base
	ORDER_TYPES = %w(CadOrder PrintOrder)
	CARRIERS = [:fedex, :usps, :ups, :other]

	belongs_to :project
	has_one :user, through: :project

	validates :title, presence: true
	validates :order_type, presence: true, inclusion: { in: ORDER_TYPES }
	validates :project, presence: true
	validates :price, numericality: { greater_than: 0 }, allow_nil: true

	delegate :title, to: :project, prefix: true
	delegate :name, to: :user, prefix: true

	# TODO
	# has_and_belongs_to_many :assets
	# TODO
	# validate assets belong to project
	# TODO
	# validate has assets
	# validates :assets, presence: true

	include Stateflow

	#     _        _                       _    _          
	#  __| |_ __ _| |_ ___   _ __  __ _ __| |_ (_)_ _  ___ 
	# (_-<  _/ _` |  _/ -_) | '  \/ _` / _| ' \| | ' \/ -_)
	# /__/\__\__,_|\__\___| |_|_|_\__,_\__|_||_|_|_||_\___|

	# it's kind of non-standard to mix events and states when writing
	# a state machine, but I think it makes it more readable in this case.
	# STATES: submitted estimated production completed shipped archived
	stateflow do
		# per https://github.com/ryanza/stateflow/issues/44
		state_column :state # needs to be explicit because of STI

		initial :submitted

		# we start in submitted state
		state :submitted

		# making an estimate takes us to submitted state
		event :estimate do
			transitions from: :submitted, to: :estimated, if: :has_price?
		end

		# send the estimate to the client on entry
		state :estimated do
			enter :notify_estimate
		end

		# if the client doesn't like the estimate, we go back to submitted
		event :modify do
			transitions from: :estimates, to: :submitted
		end

		# if the client has paid, go to production state
		event :pay do
			transitions from: :estimated, to: :production, if: :payment_processed?
		end

		# since the client has paid, tell everyone to start the job and send a thank you
		state :production do
			enter :notify_paid
		end

		# the job is done! 
		event :complete do
			transitions from: :production, to: :completed
		end

		# notify the client that the job is done on entry
		state :completed do
			enter :notify_complete
		end

		# if this a cad order, shippable? checks that there is a shipped file attached
		# if it is a print order, there must be a tracking number
		# implement correctly in the subclasses
		event :ship do
			transitions from: :completed, to: :shipped, if: :shippable?
		end

		state :shipped do
			enter :notify_shipped
		end

		event :archive do
			transitions from: :shipped, to: :archived
		end

		state :archived
	end

	# 	          _   _  __ _         _   _             
	#  _ _  ___| |_(_)/ _(_)__ __ _| |_(_)___ _ _  ___
	# | ' \/ _ \  _| |  _| / _/ _` |  _| / _ \ ' \(_-<
	# |_||_\___/\__|_|_| |_\__\__,_|\__|_\___/_||_/__/

	def notify_estimate
		# send estimate to the client
	end

	def notify_paid
		# notify staff to begin production
		# send thank-you note to client
	end

	def notify_complete
		# notify the client the order is complete
	end

	def notify_shipped
		# notify the client the shipment has been made, with the tracking number and link
	end
                                                
	#     _        _                        _ _ _   _             
	#  __| |_ __ _| |_ ___   __ ___ _ _  __| (_) |_(_)___ _ _  ___
	# (_-<  _/ _` |  _/ -_) / _/ _ \ ' \/ _` | |  _| / _ \ ' \(_-<
	# /__/\__\__,_|\__\___| \__\___/_||_\__,_|_|\__|_\___/_||_/__/
                                                            
	def has_price?
		!price.nil?
	end

	def payment_processed?
		!confirmation.blank?
	end

	def shippable?
		!tracking_number.blank?
		# TODO if cad order, check for shippable files attached
	end
end

# class CadOrder < Order
# 	# TODO
# 	# has_and_belongs_to_many :shipped_files

# 	# validates? has shipped files if state is shipped

# 	def shippable?
# 		# checks for having at least one shipped file
# 	end
# end

# class PrintOrder < Order
# 	CARRIERS = [:fedex, :usps, :ups, :other]

# 	# validates has carrier/tracking number if state is shipped

# 	# validates carrier
# 	validates :carrier, inclusion: {in: CARRIERS }

# 	# validates tracking number

# 	# validates :tracking_number, format: {with: /regexp for carrier/}, {scope: (carrier == 'fedex')}
# 	# and so forth

# 	# DRYer:
# 	# CARRIER_REGEXPS = {fedex: /nnn/, usps: /mmm/}
# 	# CARRIERS = CARRIER_REGEXPS.keys

# 	def shippable?
# 		# check for tracking number
# 	end
# end