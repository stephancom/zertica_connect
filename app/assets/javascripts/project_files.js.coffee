# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	$('input[type^="filepicker"]').on 'change', (event)->
		if event.originalEvent.fpfile?
			$('input[data-filepicker-meta="filename"]').val(event.originalEvent.fpfile.filename)
			$('input[data-filepicker-meta="size"]').val(event.originalEvent.fpfile.size)
			$('input[data-filepicker-meta="mimetype"]').val(event.originalEvent.fpfile.mimetype)
		else
			$('input[data-filepicker-meta="filename"]').val('')
			$('input[data-filepicker-meta="size"]').val('')
			$('input[data-filepicker-meta="mimetype"]').val('')
