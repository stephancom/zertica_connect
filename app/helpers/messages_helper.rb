module MessagesHelper
	def sender_class(message)
		case message.sender
		when nil
			:system
		when current_user
			:myself
		else
			:staff
		end
	end

	def message_attrs(message)
		{ id: dom_id(message), class: [dom_class(message), sender_class(message)] }
	end
end