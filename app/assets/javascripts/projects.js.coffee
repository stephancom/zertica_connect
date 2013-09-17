# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

CKEDITOR.config.toolbar = [["Styles", "Format", "Font", "FontSize"], "/", ["Bold", "Italic", "Underline", "StrikeThrough", "-", "Undo", "Redo", "-", "Cut", "Copy", "Paste", "Find", "Replace", "-", "Outdent", "Indent", "-", "Print"], "/", ["NumberedList", "BulletedList", "-", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock"], ["Image", "Table", "-", "Link", "Flash", "Smiley", "TextColor", "BGColor", "Source"]]
CKEDITOR.config.uiColor = '#6ae207'
ready = ->
	$('.ckeditor').ckeditor 
	
jQuery ->
	ready
	$(document).on "page:load", ready