# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/jQuery ->

jQuery ->

$(document).ready ->
 $ ->
  $(".toggleClose2").hide()
  $(".toggle").hide()
  $(".argcoms").hide()


  $(".toggleOpen").click ->
    	$(this).hide().parent().parent().next("#coco").children(".toggle").slideDown("medium").parent().siblings("#title5").children(".cont").hide().parent().parent().parent().siblings(".toggleClose2").show().closest("#initial").siblings(".argcoms").show()
	    
	 

  $(".arrow-up-argument").click ->
    $(this).parents(".toggleClose2").hide().siblings("#descente").children("#descente2").children("#coco").children(".toggle").hide().parent().siblings("#title5").children(".cont").show().parent().siblings("#coco1").children(".stats").children(".toggleOpen").show().closest("#initial").siblings(".argcoms").hide()

