require 'ruby-mpd'

class BackEnd
  def initialize
    @mpd = MPD.new 'localhost', 6600

    @mpd.connect

    # settings
    @mpd.random = true
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

  # add all songs from the playlist to queue and play first
  def play(playlist)
   @mpd.clear

    playlist.songs.each do |song|
      @mpd.add song
    end

   @mpd.play
  end

  def volume(set=0)
    set == 0 ? @mpd.volume : (@mpd.volume = @mpd.volume + set)
  end

  def prev
    @mpd.previous
  end

  def next
    @mpd.next
  end

  def pause
    @mpd.pause = !@mpd.paused?
  end

  def disconnect
    @mpd.disconnect
  end
end
