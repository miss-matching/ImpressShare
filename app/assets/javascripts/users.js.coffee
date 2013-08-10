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
