$(document).on 'change', '#user_ward_id', ->
  $.ajax(
    type: 'GET'
    url:  '/users/stations_select'
    data: {
      ward_id: $(this).val()
    }
  ).done (data) ->
    $('#user_station_id').html(data)