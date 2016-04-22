# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '200454'
Pusher.key = '0d846fc26187e9741029'
Pusher.secret = '805627e7f759c6448c37'
Pusher.logger = Rails.logger
Pusher.encrypted = true

# this should be in: app/controllers/hello_world_controller.rb
#class HelloWorldController < ApplicationController
#  def hello_world
#    Pusher.trigger('test_channel', 'my_event', {
#      message: 'hello world'
#    })
#  end
end
