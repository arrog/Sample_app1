# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->

$(document).ready ->
 $ ->
  $("#box-argument").hide()
  $("#to-be-closed").hide()
  $(".arrow-up-context").hide()
  $(".arrow-up-newarg").hide()
  $(".arrow-up-comments").hide()
  $("#comments-to-open").hide()
  $(".comment-texte2").hide()


  $(".arrow-down-newarg").click ->
	    $(this).hide().siblings(".arrow-up-newarg").show().parent().siblings("#box-argument").slideDown("medium")

  $(".arrow-up-newarg").click ->
	    $(this).hide().siblings(".arrow-down-newarg").show().parent().siblings("#box-argument").slideUp("fast")

  $(".arrow-down-context").click ->
	    $(this).hide().siblings(".arrow-up-context").show().parent().siblings("#to-be-closed").slideDown("fast")

  $(".arrow-up-context").click ->
    	$(this).hide().siblings(".arrow-down-context").show().parent().siblings("#to-be-closed").slideUp("fast")

  $(".arrow-down-comments").click ->
	    $(this).hide().siblings(".arrow-up-comments").show().siblings(".comment-texte1").hide().siblings(".comment-texte2").show().parent().siblings("#comments-to-close").hide().siblings("#comments-to-open").slideDown("slow")

  $(".arrow-up-comments").click ->
	    $(this).hide().siblings(".arrow-down-comments").show().siblings(".comment-texte2").hide().siblings(".comment-texte1").show().parent().siblings("#comments-to-open").hide().siblings("#comments-to-close").slideDown("slow")
