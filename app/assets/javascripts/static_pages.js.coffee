# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->

$(document).ready ->

 $ ->

  $("#video01").hide()
  $("#video02").hide()
  $("#video03").hide()
  $("#video2_01").hide()
  $("#video2_02").hide()
  $("#video2_03").hide()
  $(".image2-expl").hide()
  $('.en-ce-moment1').hide()
  $('.en-ce-moment2').hide()
  $('.en-ce-moment3').hide()
  $('.en-ce-moment4').hide()
  $('#best-debates5').hide()

  $(".rotate").textrotator
  		animation: "flipUp"
  		separator: ","
  		speed: 3000

  $(".image1-expl").mouseover ->
    	$(this).hide().siblings(".image2-expl").show()

  $(".image2-expl").mouseout ->
    	$(this).hide().siblings(".image1-expl").show()
  
  $("#best-debates1").click ->
	    $(this).parent().siblings("#en-bas").children("#best-debates5").hide().siblings("#best-debates3").show()

  $("#best-debates2").click ->
	    $(this).parent().siblings("#en-bas").children("#best-debates3").hide().siblings("#best-debates5").show()

  $(".flechehome").click ->
	    $(this).parents(".en-ce-moment").hide().siblings(".en-ce-moment1").show()

  $(".flechehome1").click ->
	    $(this).parents(".en-ce-moment1").hide().siblings(".en-ce-moment2").show()

  $(".flechehome2").click ->
	    $(this).parents(".en-ce-moment2").hide().siblings(".en-ce-moment3").show()

  $(".flechehome3").click ->
	    $(this).parents(".en-ce-moment3").hide().siblings(".en-ce-moment4").show()		

  $(".fleche01").click ->
    	$(this).parent().hide().siblings("#video01").show()

  $(".fleche02").click ->
    	$(this).parent().hide().siblings("#video02").show()

  $(".fleche03").click ->
	   	$(this).parent().hide().siblings("#video03").show()

  $(".fleche10").click ->
    	$(this).parent().hide().siblings("#video2_01").show()


  $(".fleche11").click ->
    	$(this).parent().hide().siblings("#video2_02").show()

  $(".fleche12").click ->
    	$(this).parent().hide().siblings("#video2_03").show()


  $("#fermer-explication").click ->
    	$(this).parent().parent().parent().hide()
 
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