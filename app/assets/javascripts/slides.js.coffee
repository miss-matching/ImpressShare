# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  # convert markdown to impress, then display
  refreshPreview = ->
    url = "/slides/preview"
    console.log url
    $.post(url, { content: $('#markdown-content').val(), location: preview.location.href })
    .done (data)->
      console.log data.page
      preview.location.href = data.slide_path  
      preview.location.href = data.page if data.page

  
  # refresh
  $('#btn-preview').on 'click', ->
    refreshPreview()

  # reload markdown content, then refreash the preview
  $('#btn-reload').on 'click', ->
    slide_id = $('input[name=slide-id]').val()
    slide_show_url = "/slides/#{slide_id}"
    slide_preview_url = "/slides/preview"
    $.getJSON(slide_show_url)
    .done (data)->
      $('#markdown-content').val( data.markdown_content )
      refreshPreview()

  $('#controlls .next').on 'click', ->
    $("#preview")[0].contentWindow.impress().next()
    false

  $('#controlls .prev').on 'click', ->
    $("#preview")[0].contentWindow.impress().prev()
    false

  $('#controlls .fullscrean').on 'click', ->
    $("#preview")[0].webkitRequestFullScreen()
    false

