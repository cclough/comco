# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.main_video_start = () ->

  $("#panel_signup").hide()
  $("#panel_main").show()

  # Docs here: http://icecomm.io/docs
  window.comm = new Icecomm('LokeLkORNgDu8tiLGGOvs7cDAlt3UWyRZ7QLB7UECDj7GRQ52S')
  
  # video_token is the room name
  window.comm.connect "main_room", audio: true

  window.comm.on 'connected', (peer) ->
    $("#panel_main_waiting").addClass("arrived").html("Connecting...")
    setTimeout (->
      $("#panel_main_video_remote").append(peer.getVideo())
      $("#panel_main_waiting").hide()
    ),1000

    # $("#vided_index_camera_off").show()
    return
  window.comm.on 'local', (peer) ->
    window.local_peer = peer # so can restart onload
    localVideo.src = peer.stream
    localVideo.muted = true # this is just for feedback

    window.main_timer_start()

    return
  window.comm.on 'disconnect', (peer) ->
    document.getElementById(peer.ID).remove()

    $("#panel_main_waiting").removeClass("arrived").html("Not connected").show()

    # $("#vided_index_camera_off").show()
    return



window.main_timer_start = () ->
  i = 60
  countdown = setInterval (->
    $("#panel_main_timer").html(i)
    i = i - 1
    ),1000



$(document).ready ->

  $("#panel_signup_button_start").click ->
    window.main_video_start()

