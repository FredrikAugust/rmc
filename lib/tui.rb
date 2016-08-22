require 'ncurses'
require './back_end.rb'

# create a new backend from the backend class
@back_end = BackEnd.new

# create a screen object
Ncurses.initscr

# global declarations
@maxy, @maxx = [Ncurses.getmaxy(Ncurses.stdscr) - 1,
                Ncurses.getmaxx(Ncurses.stdscr) - 1]

@pos = 0

# method to write currently playing song
def write_currently_playing
  Ncurses.mvaddstr(@maxy, 0, @back_end.get_current_song + " "*100) # hack to overwrite old stuff
  Ncurses.refresh
  sleep(1)
end

# list availible playlists
def show_playlists(pl_list)
  pl_list.each_with_index do |e, i|
    Ncurses.mvaddstr(i, 0, (@pos == i ? "> " : "") + e.name + " "*100) # see above
    Ncurses.refresh()
  end
end

# play the playlist
def play(playlist)
  @back_end.play(playlist)
end


begin
  Ncurses.cbreak()
  # don't output what you type on the screen
  Ncurses.noecho()

  # don't show cursor
  Ncurses.curs_set(0)
 
  write_currently_playing

  #load playlists
  playlists = @back_end.get_playlists

  # show playlists
  show_playlists(playlists)

  @cp_t = Thread.new do
    loop do
      write_currently_playing
    end
  end

  # 113 == 'q' in the ascii table
  while((ch = Ncurses.getch()) != 113) do
    case(ch.chr)
    when 'k'
      if @pos < (playlists.size - 1)
        @pos += 1
        show_playlists(playlists)
      end
    when 'j'
      if @pos > 0
        @pos -= 1
        show_playlists(playlists)
      end
    when 'p'
      play playlists[@pos]
    end

    Ncurses.refresh()
  end
ensure
  # kill thread updating currently playing

  # disconnect from mopidy
  @back_end.disconnect
  Ncurses.curs_set(1)
  Ncurses.endwin()
end
