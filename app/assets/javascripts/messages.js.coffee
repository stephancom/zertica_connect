# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	$(".messaging_panel").each ->
		thisMessagePanel = $(this)
		# for some reason, this doesn't work unless you delay a little after page load?
		setTimeout ->
			thisMessagePanel.find('.messages').animate({ scrollTop: thisMessagePanel.find('.messages').prop("scrollHeight")}, 1000)
		, 100
		clicker = $(this).find('input[type="submit"]')
		$(this).find('textarea[name="message[body]"]').on 'keypress', (e) ->
			if e.keyCode is 13 and not e.shiftKey
				e.preventDefault()
				if not not $(@).val() # don't send if field is empty
					clicker.css('background','orange')
					clicker.trigger('click')
