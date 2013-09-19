require 'action_pusher'

class MessagesPusher < ActionPusher
  helper MessagesHelper

  def initialize(user)
    @user = user
    @message_viewer = @user
  end

  def channel
    @user.pusher_key
  end

  def add_message(message = nil)
    @message = message
    Pushable.new channel, render(template: 'messages_pusher/add_message')
  end

  def update_message(message = nil)
    @message = message
    Pushable.new channel, render(template: 'messages_pusher/update_message')
  end
end
