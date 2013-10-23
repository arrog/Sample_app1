# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->

$(document).ready ->
 $ ->

  $("#open-infos").hide() 
  $("#open-infos2").hide()
  $("#video1").hide()
  $(".image2-expl").hide()


  $(".image1-expl").mouseover ->
    	$(this).hide().siblings(".image2-expl").show()

  $(".image2-expl").mouseout ->
    	$(this).hide().siblings(".image1-expl").show()
  


  $("#fermer-explication").click ->
    	$(this).parent().parent().hide().siblings("#intro-doulin").children(".ouvrir-informations").show()
 
  $("#fermer-explication1").click ->
	    $(this).parent().parent().hide().siblings("#intro-doulin").children(".ouvrir-informations").show()


  $(".ouvrir-informations").click ->
    	$(this).hide().parent().siblings("#open-infos").show().siblings("#open-infos2").show()
  

  $(".emotion input:radio").addClass "input_hidden"
  $(".emotion label").click ->
    	$(this).addClass("selected").siblings().removeClass("selected").parent().siblings(".emotion").children().removeClass("selected")


	  $(".emotion2 input:radio").addClass "input_hidden"
	  $(".emotion2 label").click ->
	    	$(this).removeClass("non-selected").addClass("selected").siblings().removeClass("selected").addClass("non-selected").parent().siblings(".emotion2").children().removeClass("selected").addClass("non-selected")
	
		  $(".choix1").addClass("selected")
		  $(".emotion3 input:radio").addClass "input_hidden"
		  $(".emotion3 label").click ->
		    	$(this).addClass("selected").siblings().removeClass("selected")

  $(".challenge-bouton1").click ->
	    $(".lists-challenge-open").hide()
