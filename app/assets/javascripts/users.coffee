# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'change', '#user_ward_id', ->
  $.ajax(
    type: 'GET'
    url:  '/users/stations_select'
    data: {
      ward_id: $(this).val()
    }
  ).done (data) ->
    $('#user_station_id').html(data);

$ ->
  $("#wears .page").infinitescroll
    loading: {
      img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif"
      msgText: "ロード中..."
    }
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: "#wears div.wear" # selector for all items you'll retrieve
