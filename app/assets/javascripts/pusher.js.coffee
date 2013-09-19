$ ->
  pusher = new Pusher(PUSHER_KEY)
  channel = pusher.subscribe(PUSHER_USER_CHANNEL)
  channel.bind "rjs_push", (data) ->
    eval data