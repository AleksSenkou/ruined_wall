require_relative 'composition/client'

client = Composition::Client.new(width: 1600, height: 1200)

client.start!
