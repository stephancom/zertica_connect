$ ->
  pusher = new Pusher(PUSHER_KEY)
  # pusher.subscribe(PUSHER_USER_CHANNEL).bind "rjs_push", (data) ->
  #   eval data