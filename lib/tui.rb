require 'ncurses'
require './back_end.rb'

# create a new backend from the backend class
@back_end = BackEnd.new

# create a screen object
Ncurses.initscr

# global declarations
def max_vals
  @maxy, @maxx = [Ncurses.getmaxy(Ncurses.stdscr) - 1,
                  Ncurses.getmaxx(Ncurses.stdscr) - 1]
end

max_vals

@pos = 0
@playing = -1

# method to write currently playing song
def write_currently_playing
  Ncurses.mvaddstr(@maxy, 0, @back_end.get_current_song + " [#{@back_end.volume}%]" + " "*100) # hack to overwrite old stuff
  Ncurses.refresh
end

# list availible playlists
def show_playlists(pl_list)
  pl_list.each_with_index do |e, i|
    Ncurses.mvaddstr(i, 0, (@pos == i ? "> " : "") + \
                     (i == @playing ? "{ #{e.name} }" : e.name) \
                     + " "*100) # see above
    Ncurses.refresh()
  end
end


begin
  Ncurses.cbreak()
  # don't output what you type on the screen
  Ncurses.noecho()
  # enable arrow keys
  Ncurses.stdscr.keypad(true)

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
      sleep(0.5)
    end
  end

  # 113 == 'q' in the ascii table
  while((ch = Ncurses.getch()) != 113) do
    case(ch)
    when 'j'.ord, Ncurses::KEY_DOWN # down
      if @pos < (playlists.size - 1)
        @pos += 1
        show_playlists(playlists)
      end
    when 'k'.ord, Ncurses::KEY_UP # up
      if @pos > 0
        @pos -= 1
        show_playlists(playlists)
      end
    when 10, 13 # play, \n or \r
      @back_end.play playlists[@pos]
      @playing = @pos
      show_playlists(playlists)
    when 'p'.ord, 32 # pause/unpause, space
      @back_end.pause
    when '-'.ord # vol down 5%
      @back_end.volume(-5)
      write_currently_playing
    when '+'.ord # vol up 5%
      @back_end.volume(5)
      write_currently_playing
    when '>'.ord # next
      @back_end.next
      write_currently_playing
    when '<'.ord # prev
      @back_end.prev
      write_currently_playing
    when Ncurses::KEY_RESIZE
      Ncurses.clear
      max_vals     
      show_playlists(playlists)
      write_currently_playing
    end

    Ncurses.refresh()
  end
ensure
  # disconnect from mopidy
  @back_end.disconnect
  Ncurses.curs_set(1)
  Ncurses.endwin()
end
