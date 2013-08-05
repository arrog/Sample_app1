# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

$(document).ready ->
 $ ->
  $("#create-debate").hide()

  $("#badge1").click ->
    $(this).parent().parent().hide().siblings("#group-header").hide().siblings("#create-debate").show().children(".papa-debat").hide()

  $("#fermer-barredebat").click ->
    $(this).parent().hide().siblings("#papa1").show().siblings("#group-header").show()

  $(".defi-groupnav").click ->
    $(this).parent().siblings(".papa-debat").hide().siblings(".papa-challenge").show()

  $(".debat-groupnav").click ->
    $(this).parent().siblings(".papa-debat").show().siblings(".papa-challenge").hide()