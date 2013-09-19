# http://stackoverflow.com/a/6753926/444955
class ActionPusher < AbstractController::Base
  include AbstractController::Rendering
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include Rails.application.routes.url_helpers
  helper ApplicationHelper
  self.view_paths = "app/views"

  class Pushable
    def initialize(channel, pushtext)
      @channel = channel
      @pushtext = pushtext
    end

    def push
      Pusher[@channel].trigger('rjs_push', @pushtext )
    end
  end
end