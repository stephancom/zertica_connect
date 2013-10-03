# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	$('input#project_file_url').on 'change', (event)->
		# TODO yeah, not this
		alert("boo!")
		if event.originalEvent.fpfile?
			$('input#asset_title').val(event.originalEvent.fpfile.filename)
		else
			$('input#asset_title').val('')
