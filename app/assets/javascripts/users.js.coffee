# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->

$(document).ready ->
 $ ->
  $(".nouvelle-image").hide()
  

  $(".boutons-sociaux-image").click ->
    	$(this).hide().siblings('.nouvelle-image').show()