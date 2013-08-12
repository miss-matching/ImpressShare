# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  $('#controlls .next').on 'click', ->
    $("#preview")[0].contentWindow.impress().next()
    false

  $('#controlls .prev').on 'click', ->
    $("#preview")[0].contentWindow.impress().prev()
    false

  $('#controlls .fullscrean').on 'click', ->
    $("#preview")[0].webkitRequestFullScreen()
    false

  $('.button-view .next').on 'click', ->
    $("#preview")[0].contentWindow.impress().next()
    false

  $('.button-view .prev').on 'click', ->
    $("#preview")[0].contentWindow.impress().prev()
    false

  $('.button-view .fullscrean').on 'click', ->
    $("#preview")[0].webkitRequestFullScreen()
    false

  $('#slide-edit .controls .commit').on 'click', ->
    form = $(@).closest("form")
    $('#published_status').val("1")
    form.submit()

  $('#slide-edit .controls .draft').on 'click', ->
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


######################
# EDIT
######################
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
    $('.markdown-preview').removeClass('hidden')
    $('.markdown-content').addClass('hidden')

  $('#btn-edit').on 'click', ->
    $('.markdown-preview').addClass('hidden')
    $('.markdown-content').removeClass('hidden')


  # reload markdown content, then refreash the preview
  $('#btn-reload').on 'click', ->
    slide_id = $('input[name=slide-id]').val()
    slide_show_url = "/slides/#{slide_id}"
    slide_preview_url = "/slides/preview"
    $.getJSON(slide_show_url)
    .done (data)->
      $('#markdown-content').val( data.markdown_content )
      refreshPreview()
  

  $('#slide-edit .slide-kind').on 'change', ->
    window.initializeEditViewBySlideKind()

  window.initializeEditViewBySlideKind = ->
    kind = $('#slide-edit .slide-kind')
    GITHUB = "0"
    MARKDOWN = "1"
    if kind.val() == GITHUB
      $('#slide-edit .edit-for-markdown').addClass('hidden')
      $('#slide-edit .edit-for-github').removeClass('hidden')
    else if kind.val() == MARKDOWN
      $('#slide-edit .edit-for-markdown').removeClass('hidden')
      $('#slide-edit .edit-for-github').addClass('hidden')



