# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.onload = (e) ->
  liff.init (data) ->
    userId = data.context.userId
    document.getElementById('userid').value = userId
    return
  return
