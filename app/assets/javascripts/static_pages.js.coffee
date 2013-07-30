# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->

$(document).ready ->
 $ ->
  $(".ouvrir-informations").hide()


  $("#fermer-explication").click ->
    	$(this).parent().parent().hide().siblings("#intro-doulin").children(".ouvrir-informations").show()
 

  $(".ouvrir-informations").click ->
    	$(this).hide().parent().siblings("#open-infos").show()    
	
