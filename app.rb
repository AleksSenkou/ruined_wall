require_relative 'composition/client'

client = Composition::Client.new(width: 640, height: 480)

client.draw!
