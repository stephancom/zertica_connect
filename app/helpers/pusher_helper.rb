module PusherHelper
  def pusher_attribute(name, value)
    content_tag(:script, "var PUSHER_#{name} = '#{value}';".html_safe)
  end
  def pusher_attributes(hash)
    content_tag(:script, hash.map { |k, v| "var PUSHER_#{k} = '#{v}';" }.join.html_safe)
  end
  def pusher_debug
    content_tag :script, "Pusher.log = function(message) { if (window.console && window.console.log) window.console.log(message); }; WEB_SOCKET_DEBUG = true;".html_safe unless Rails.env.production?
  end
  def pusher_script
    javascript_include_tag("http://js.pusherapp.com/1.8/pusher.min.js")
  end
  def pusher_setup
    pusher_attributes( 'KEY' => Pusher.key, 'USER_CHANNEL' => (current_user.pusher_key if current_user)) + pusher_script + pusher_debug
  end
end