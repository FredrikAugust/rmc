require 'ruby-mpd'

class BackEnd
  def initialize
    @mpd = MPD.new 'localhost', 6600

    @mpd.connect
  end

  def get_current_song
    song = @mpd.current_song
    return "Nothing currently playing" if @mpd.stopped?
    "Playing: #{song.artist} > #{song.title}"
  end

  def disconnect
    @mpd.disconnect
  end
end
