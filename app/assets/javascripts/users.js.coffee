# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Slides = []
window.Slides.loadPublishedSlidesOwnedBy = (user_id) ->
  $.getJSON("/users/#{user_id}/slides.json" )
  .done (data)->
    $.each data.htmls , (key, html )->
      $('#published-slides').append(html)

window.Slides.loadDraftSlidesOwnedBy = (user_id) ->
  $.getJSON("/users/#{user_id}/slides.json", {status: "draft"})
  .done (data)->
    $.each data.htmls , (key, html )->
      $('#draft-slides').append(html)


# user profile #
$ ->
  $('.user-menu ul li .slide').on 'click', ->
    $('.user-rigit-content > *').addClass('hidden')
    $('.user-slide-content').removeClass('hidden')

  $('.user-menu ul li .draft').on 'click', ->
    $('.user-rigit-content > *').addClass('hidden')
    $('.user-draft-content').removeClass('hidden')
  
  $('.user-menu ul li .favorite-user').on 'click', ->
    $('.user-rigit-content > *').addClass('hidden')
    $('.user-favorite-content').removeClass('hidden')

  $('.user-menu ul li .favorite-slide').on 'click', ->
    $('.user-rigit-content > *').addClass('hidden')
    $('.user-favorite-slide-content').removeClass('hidden')

  $('.user-menu ul li .favorite-presen').on 'click', ->
    $('.user-rigit-content > *').addClass('hidden')
    $('.user-favorite-presen-content').removeClass('hidden')
