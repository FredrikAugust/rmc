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

  # return an array of playlists
  def get_playlists
    @mpd.playlists
  end

  # add all songs from the playlist to queue and then shuffle and play first
  def play(playlist)
   @mpd.clear

    playlist.songs.each do |song|
      @mpd.add song
    end

   @mpd.shuffle
   @mpd.play
  end

  def disconnect
    @mpd.disconnect
  end
end
