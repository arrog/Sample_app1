# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/jQuery ->

jQuery ->

$(document).ready ->
 $ ->
  $(".toggleClose2").hide()
  $(".toggle").hide()
  $(".argcoms").hide()
  $('.modifs').hide()
  $('.modifs2').hide()
  $('.effacersur').hide()
  $('.signalisation').hide()
  $('.finalementnon2').hide()
  $('#new-argument-photo').hide()
  $('#new-argument-video').hide()
  

  $(".box-pic").click ->
    	$(this).parents().parent().parent().parent().siblings("#new-argument-photo").show().siblings('#new-argument').hide().siblings('#new-argument-video').hide()

  $(".box-video").click ->
    $(this).parents().parent().parent().parent().siblings("#new-argument-video").show().siblings('#new-argument').hide().siblings('#new-argument-photo').hide()

  $(".box-texte").click ->
    $(this).parents().parent().parent().parent().siblings("#new-argument").show().siblings('#new-argument-photo').hide().siblings('#new-argument-video').hide()	
  
  $(".flags").mouseover ->
    	$(this).hide().siblings(".signalisation").show().siblings(".finalementnon2").show()

  $(".effacer").click ->
    	$(this).hide().siblings('.texte').hide().siblings('.effacersur').show()

  $(".finalementnon").click ->
    	$(this).parent().hide().siblings('.texte').show().siblings('.effacer').show()

  $(".finalementnon2").click ->
    	$(this).parent().hide()


  $(".toggleOpen").click ->
    	$(this).hide().parent().parent().next("#coco").children(".toggle").slideDown("medium").parent().siblings("#title5").children(".cont").hide().parent().parent().parent().siblings(".toggleClose2").show().closest("#initial").siblings(".argcoms").show().siblings("#initial").children(".modifs").show()

  $(".arrow-up-argument").click ->
    $(this).parents(".toggleClose2").hide().siblings("#descente").children("#descente2").children("#coco").children(".toggle").hide().parent().siblings("#title5").children(".cont").show().parent().siblings("#coco1").children(".stats").children(".toggleOpen").show().closest("#initial").siblings(".argcoms").hide().siblings("#initial").children(".modifs").hide().siblings(".modifs2").hide()


  $(".toggleClose").click ->
    $(this).parents(".toggleClose2").hide().siblings("#descente").children("#descente2").children("#coco").children(".toggle").hide().parent().siblings("#title5").children(".cont").show().parent().siblings("#coco1").children(".stats").children(".toggleOpen").show().closest("#initial").siblings(".argcoms").hide().siblings("#initial").children(".modifs").hide().siblings(".modifs2").hide()

