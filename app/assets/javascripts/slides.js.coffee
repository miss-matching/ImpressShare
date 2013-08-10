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

  $('#form-controller .commit').on 'click', ->
    form = $(@).closest("form")
    $('#published_status').val("1")
    form.submit()

  $('#form-controller .draft').on 'click', ->
    form = $(@).closest("form")
    $('#published_status').val("0")
    form.submit()

  $('#presentation .controlls .full-screen').on 'click', ->
    $("#presentation")[0].webkitRequestFullScreen()
    false

  $('#presentation .tab-controlls .members-tab').on 'click', ->
    $("#presentation .logs").addClass("hidden")
    $("#presentation .members").removeClass("hidden")
    $('#presentation .tab-controlls .members-tab').addClass("active")
    $('#presentation .tab-controlls .logs-tab').removeClass("active")
    false
  $('#presentation .tab-controlls .logs-tab').on 'click', ->
    $("#presentation .members").addClass("hidden")
    $("#presentation .logs").removeClass("hidden")
    $('#presentation .tab-controlls .logs-tab').addClass("active")
    $('#presentation .tab-controlls .members-tab').removeClass("active")
    false
  $('#presentation .controlls .be-a-presenter').on 'click', ->
    alert 'パスワード入れて、プレゼンターになろう！'

  $('#presentation .controlls .sync').on 'click', ->
    $(@).toggleClass("sync-on")




