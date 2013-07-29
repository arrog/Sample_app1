# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/jQuery ->

jQuery ->

$(document).ready ->
 $ ->
  $(".toggle").hide()
  $(".argcoms").hide()


  $(".toggleOpen").click ->
    	$(this).hide().parent().parent().next("#coco").children(".toggle").slideDown("medium").parent().siblings("#title5").children(".cont").hide().closest("#initial").siblings(".argcoms").show()
	    
	 

  $("p.toggleClose").click ->
    $(this).parents(".toggle").slideUp("fast").parent().siblings("#title5").children(".cont").show().parent().siblings("#coco1").children(".stats").children(".toggleOpen").show().closest("#initial").siblings(".argcoms").hide()

