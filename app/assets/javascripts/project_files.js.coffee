# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	$('input#project_file_url').on 'change', (event)->
		if event.originalEvent.fpfile?
			$('input#project_file_filename').val(event.originalEvent.fpfile.filename)
			$('input#project_file_size').val(event.originalEvent.fpfile.size)
			$('input#project_file_mimetype').val(event.originalEvent.fpfile.mimetype)
		else
			$('input#project_file_filename').val('')
			$('input#project_file_size').val('')
			$('input#project_file_mimetype').val('')
