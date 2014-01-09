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
  $(".texte2-newarg").hide()
  $(".arrow-up-comments").hide()
  $("#comments-to-open").hide()
  $(".comment-texte2").hide()
  $(".invitation-fermer").hide()
  $(".invitation-fermer1").hide()
  $(".invitation-fermer-american").hide()
  $(".invitation-fermer1-american").hide()
  $(".invitation-fermer3-american").hide()
  $(".invitation-fermer4-american").hide()
  $(".invitation-fermer").hide()
  $(".invitation-fermer1").hide()
  $(".invitation-fermer-fc").hide()
  $(".invitation-fermer1-fc").hide()
  $(".invitation-fermer3-fc").hide()
  $(".invitation-fermer4-fc").hide()
  $(".invitation-fermer-british").hide()
  $(".invitation-fermer1-british").hide()
  $(".invitation-fermer3-british").hide()
  $(".invitation-fermer4-british").hide()
  $(".invitation-fermer2-british").hide()
  $(".invitation-fermer12-british").hide()
  $(".invitation-fermer32-british").hide()
  $(".invitation-fermer42-british").hide()




  $("#invitation-british").click ->
	    $(this).parent().parent().hide().siblings(".invitation-fermer-british").show()

  $("#fermer-invitation-british").click ->
	    $(this).parent().parent().hide().siblings(".image1").show()
	
  $("#invitation2-british").click ->
	    $(this).parent().parent().hide().siblings(".invitation-fermer2-british").show()

  $("#fermer-invitation2-british").click ->
	    $(this).parent().parent().hide().siblings(".image1").show()

  $("#invitation3-british").click ->
  	    $(this).parent().parent().hide().siblings(".invitation-fermer3-british").show()

  $("#fermer-invitation3-british").click ->
  	    $(this).parent().parent().hide().siblings(".image1").show()

  $("#invitation32-british").click ->
  	    $(this).parent().parent().hide().siblings(".invitation-fermer32-british").show()

  $("#fermer-invitation32-british").click ->
  	    $(this).parent().parent().hide().siblings(".image1").show()


  $("#invitation1-british").click ->
 	    $(this).parent().parent().hide().siblings(".invitation-fermer1-british").show()

  $("#fermer-invitation1-british").click ->
 	    $(this).parent().parent().hide().siblings(".image1").show()

  $("#invitation12-british").click ->
 	    $(this).parent().parent().hide().siblings(".invitation-fermer12-british").show()

  $("#fermer-invitation12-british").click ->
 	    $(this).parent().parent().hide().siblings(".image1").show()

  $("#invitation4-british").click ->
   	    $(this).parent().parent().hide().siblings(".invitation-fermer4-british").show()

  $("#fermer-invitation4-british").click ->
   	    $(this).parent().parent().hide().siblings(".image1").show()

  $("#invitation42-british").click ->
   	    $(this).parent().parent().hide().siblings(".invitation-fermer42-british").show()

  $("#fermer-invitation42-british").click ->
   	    $(this).parent().parent().hide().siblings(".image1").show()  
 
	

  $("#invitation3-fc").click ->
	    $(this).parent().hide().siblings(".invitation-fermer3-fc").show()

  $("#fermer-invitation3-fc").click ->
	    $(this).parent().parent().hide().siblings(".first_user").show()

  $("#invitation4-fc").click ->
	    $(this).parent().hide().siblings(".invitation-fermer4-fc").show()

  $("#fermer-invitation4-fc").click ->
	    $(this).parent().parent().hide().siblings(".second_user").show()


  $("#invitation-fc").click ->
	    $(this).parent().hide().siblings(".invitation-fermer-fc").show()

  $("#fermer-invitation-fc").click ->
	    $(this).parent().parent().hide().siblings(".first_user").show()

  $("#invitation1-fc").click ->
	    $(this).parent().hide().siblings(".invitation-fermer1-fc").show()

  $("#fermer-invitation1-fc").click ->
	    $(this).parent().parent().hide().siblings(".second_user").show()



  $("#invitation3-american").click ->
	    $(this).parent().hide().siblings(".invitation-fermer3-american").show()

  $("#fermer-invitation3-american").click ->
	    $(this).parent().parent().hide().siblings(".first_user").show()

  $("#invitation4-american").click ->
	    $(this).parent().hide().siblings(".invitation-fermer4-american").show()

  $("#fermer-invitation4-american").click ->
	    $(this).parent().parent().hide().siblings(".second_user").show()


  $("#invitation-american").click ->
	    $(this).parent().hide().siblings(".invitation-fermer-american").show()

  $("#fermer-invitation-american").click ->
	    $(this).parent().parent().hide().siblings(".first_user").show()
	
  $("#invitation1-american").click ->
	    $(this).parent().hide().siblings(".invitation-fermer1-american").show()

  $("#fermer-invitation1-american").click ->
	    $(this).parent().parent().hide().siblings(".second_user").show()
	

 $("#invitation").click ->
	    $(this).parent().hide().siblings(".invitation-fermer").show()

  $("#fermer-invitation").click ->
	    $(this).parent().parent().hide().siblings(".first_user").show()

 $("#invitation1").click ->
	    $(this).parent().hide().siblings(".invitation-fermer1").show()

  $("#fermer-invitation1").click ->
	    $(this).parent().parent().hide().siblings(".second_user").show()

  $(".arrow-down-newarg").click ->
	    $(this).hide().siblings(".texte-newarg").hide().siblings(".arrow-up-newarg").show().siblings('.texte2-newarg').show().parent().siblings("#box-argument").slideDown("medium")

  $(".arrow-up-newarg").click ->
	    $(this).hide().siblings(".texte2-newarg").hide().siblings(".arrow-down-newarg").show().siblings('.texte-newarg').show().parent().siblings("#box-argument").slideUp("fast")

  $(".arrow-down-context").click ->
	    $(this).hide().siblings(".arrow-up-context").show().parent().siblings("#to-be-closed").slideDown("fast")

  $(".arrow-up-context").click ->
    	$(this).hide().siblings(".arrow-down-context").show().parent().siblings("#to-be-closed").slideUp("fast")

  $(".arrow-down-comments").click ->
	    $(this).hide().siblings(".arrow-up-comments").show().siblings(".comment-texte1").hide().siblings(".comment-texte2").show().parent().siblings("#comments-to-close").hide().siblings("#comments-to-open").slideDown("slow")

  $(".arrow-up-comments").click ->
	    $(this).hide().siblings(".arrow-down-comments").show().siblings(".comment-texte2").hide().siblings(".comment-texte1").show().parent().siblings("#comments-to-open").hide().siblings("#comments-to-close").slideDown("slow")
