module MessagesHelper
	def sender_class(message)
		if (@message_viewer == message.admin) or (@message_viewer == message.user and message.admin_id.nil?)
			:myself
		else
			:staff
		end
	end

	def message_attrs(message)
		{ id: dom_id(message), class: [dom_class(message), sender_class(message)] }
	end
end
