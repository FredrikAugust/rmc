require 'ruby-mpd'

mpd = MPD.new 'localhost', 6600, { callbacks: true }

mpd.connect

puts 'connected!'

mpd.disconnect
