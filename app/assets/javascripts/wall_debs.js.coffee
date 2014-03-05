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
  $(".bulle1").hide()
  $(".bulle2").hide()
  $(".bulle3").hide()
  $("#hover-categorie").hide()


  $("#catcat").mouseover ->
	    $(this).siblings("#hover-categorie").show()

  $("#catcat").mouseout ->
	    $(this).siblings("#hover-categorie").hide()	

  $(".image-bulle31").mousevover ->
	    $(this).parents("#british").children(".container").children("#explications").children(".bulle1").show()

  $(".image-bulle31").mouseout ->
	    $(this).parents("#british").children(".container").children("#explications").children(".bulle1").hide()


 $(".image-bulle32").mouseover ->
	    $(this).parents("#british").children(".container").children("#explications").children(".bulle2").show()

 $(".image-bulle32").mouseout ->
	    $(this).parents("#british").children(".container").children("#explications").children(".bulle2").hide()

 $(".image-bulle33").mouseover ->
	    $(this).parents("#british").children(".container").children("#explications").children(".bulle3").show()

 $(".image-bulle33").mouseout ->
	    $(this).parents("#british").children(".container").children("#explications").children(".bulle3").hide() 

 $(".image-bulle21").mouseover ->
	    $(this).parents("#fc").children(".container").children("#explications").children(".bulle1").show()

  $(".image-bulle21").mouseout ->
	    $(this).parents("#fc").children(".container").children("#explications").children(".bulle1").hide()


 $(".image-bulle22").mouseover ->
	    $(this).parents("#fc").children(".container").children("#explications").children(".bulle2").show()

 $(".image-bulle22").mouseout ->
	    $(this).parents("#fc").children(".container").children("#explications").children(".bulle2").hide()

 $(".image-bulle23").mouseover ->
	    $(this).parents("#fc").children(".container").children("#explications").children(".bulle3").show()

 $(".image-bulle23").mouseout ->
	    $(this).parents("#fc").children(".container").children("#explications").children(".bulle3").hide()


  $(".image-bulle11").mouseover ->
	    $(this).parents("#american").children(".container").children("#explications").children(".bulle1").show()

  $(".image-bulle11").mouseout ->
	    $(this).parents("#american").children(".container").children("#explications").children(".bulle1").hide()


 $(".image-bulle12").mouseover ->
	    $(this).parents("#american").children(".container").children("#explications").children(".bulle2").show()

 $(".image-bulle12").mouseout ->
	    $(this).parents("#american").children(".container").children("#explications").children(".bulle2").hide()

 $(".image-bulle13").mouseover ->
	    $(this).parents("#american").children(".container").children("#explications").children(".bulle3").show()

 $(".image-bulle13").mouseout ->
	    $(this).parents("#american").children(".container").children("#explications").children(".bulle3").hide()


 $(".image-bulle01").mouseover ->
	    $(this).parents("#ld").children(".container").children("#explications").children(".bulle1").show()

 $(".image-bulle01").mouseout ->
	    $(this).parents("#ld").children(".container").children("#explications").children(".bulle1").hide()


 $(".image-bulle02").mouseover ->
	    $(this).parents("#ld").children(".container").children("#explications").children(".bulle2").show()

 $(".image-bulle02").mouseout ->
	    $(this).parents("#ld").children(".container").children("#explications").children(".bulle2").hide()

 $(".image-bulle03").mouseover ->
	    $(this).parents("#ld").children(".container").children("#explications").children(".bulle3").show()

 $(".image-bulle03").mouseout ->
	    $(this).parents("#ld").children(".container").children("#explications").children(".bulle3").hide()

  $(".image-bulle1").mouseover ->
	    $(this).parents("#open-debate").children(".container").children("#explications").children(".bulle1").show()
	
  $(".image-bulle1").mouseout ->
    	$(this).parents("#open-debate").children(".container").children("#explications").children(".bulle1").hide()	
	  
	$(".image-bulle2").mouseover ->
		    $(this).parents("#open-debate").children(".container").children("#explications").children(".bulle2").show()

	  $(".image-bulle2").mouseout ->
	    	$(this).parents("#open-debate").children(".container").children("#explications").children(".bulle2").hide()
	
		  $(".image-bulle3").mouseover ->
			    $(this).parents("#open-debate").children(".container").children("#explications").children(".bulle3").show()

		  $(".image-bulle3").mouseout ->
		    	$(this).parents("#open-debate").children(".container").children("#explications").children(".bulle3").hide()

  $(".image-bullel1").mouseover ->
  	$(this).parents("#partenariat-debate").children(".container").children("#explications").children(".bulle1").show()

  $(".image-bullel1").mouseout ->
	    $(this).parents("#partenariat-debate").children(".container").children("#explications").children(".bulle1").hide()	

  $(".image-bullel2").mouseover ->
	    $(this).parents("#partenariat-debate").children(".container").children("#explications").children(".bulle2").show()

  $(".image-bullel2").mouseout ->
	    $(this).parents("#partenariat-debate").children(".container").children("#explications").children(".bulle2").hide()

  $(".image-bullel3").mouseover ->
	    $(this).parents("#partenariat-debate").children(".container").children("#explications").children(".bulle3").show()

  $(".image-bullel3").mouseout ->
	    $(this).parents("#partenariat-debate").children(".container").children("#explications").children(".bulle3").hide()


			

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

  $("#votervoter").mouseover ->
	    $(this).children(".arrow-down-newarg").hide().siblings(".texte-newarg").hide().siblings(".arrow-up-newarg").show().siblings('.texte2-newarg').show().parent().siblings("#box-argument").slideDown("slow")