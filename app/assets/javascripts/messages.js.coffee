# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	$("#messaging_panel .messages").animate({ scrollTop: $('#messaging_panel .messages').prop("scrollHeight")}, 1000)
	# $('#messaging_panel .messages').scrollTop($('#messaging_panel .messages').prop("scrollHeight"))
	$('#message_body').on 'keypress', (e) ->
		if e.keyCode is 13 and not e.shiftKey
			e.preventDefault()
			if not not $(@).val() # don't send if field is empty
				$("#message_send").trigger('click')
