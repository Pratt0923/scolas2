# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$(".product-details").on "click" ,"#buy-product", ->
		$(".overlay").toggle();
		$("#dialog").dialog
			height: 250
			width: 350
			modal: true
		return false

	$("#new_transaction").on "click", ".cancel", ->
		$(".overlay").toggle();
		$("#dialog").dialog("close")
		return false

$(document).ready(ready)
$(document).on("page:load", ready)